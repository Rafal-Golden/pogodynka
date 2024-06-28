//
//  SearchViewController.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    var model: SearchViewModel!
    var goToWeatherDetails: ((CityModel) -> Void)?
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var loadingView: UIActivityIndicatorView!
    private var noResultsLabel: NoResultLabel!
    
    var mapViewDecorator: MapViewDecorator?
    
    private var bucket = Set<AnyCancellable>()
    private var searchTextPublisher = CurrentValueSubject<String, Never>("")
    
    var topAnchor: NSLayoutYAxisAnchor {
        return searchBar.bottomAnchor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let searchPhrase = model.initialSearchPhrase {
            searchBar.text = searchPhrase
            searchTextPublisher.send(searchPhrase)
        }
    }
    
    private func configureUI() {
        configureSearchBar()
        addCountryMapView()
        configureTableView()
        configureLoadingView()
        configureNoResultsLabel()
        
        view.backgroundColor = model.bgColor
        self.title = model.title
    }
    
    private func configureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        let constraints = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        searchBar.placeholder = model.title
        searchBar.delegate = self
        self.searchBar = searchBar
    }
    
    private func updateUI() {
        model.citiesPublisher.sink { [weak self] newCities in
            self?.update()
        }.store(in: &bucket)
        
        searchTextPublisher.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] updatedText in
                self?.search(updatedText)
        }.store(in: &bucket)
        
        model.$markedMapPoint.sink { [weak self] mapPoint in
            guard let mapPoint else {
                self?.mapViewDecorator?.removeMapPoint()
                return
            }
            self?.mapViewDecorator?.add(mapPoint: mapPoint)
        }.store(in: &bucket)
    }
    
    private func search(_ typedText: String) {
        self.loadingView.startAnimating()
        self.model.searchCities(with: typedText)
        self.model.searchMarker(with: typedText)
    }
    
    private func update() {
        self.loadingView.stopAnimating()
        self.tableView.reloadData()
        self.noResultsLabel.isHidden = model.citiesCount > 0 || searchTextPublisher.value.isEmpty
    }
    
    fileprivate func addSearchToHistory() {
        if let searchPhrase = searchBar.text, searchPhrase.isEmpty == false {
            model.addHistory(searchPhrase: searchPhrase)
        }
    }
}

extension SearchViewController {
    func configureLoadingView() {
        self.loadingView = UIActivityIndicatorView(style: .large)
        loadingView.color = .black
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        let constraints = [
            loadingView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        loadingView.hidesWhenStopped = true
        loadingView.stopAnimating()
    }
    
    func configureNoResultsLabel() {
        noResultsLabel = NoResultLabel(text: model.noResultsMessage,
                                       textColor: AppColors.hintText,
                                       backgroundColor: AppColors.hintBackground,
                                       padding: 20.0)
        noResultsLabel.isHidden = true
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(noResultsLabel)
        
        let constraints = [
            noResultsLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let searchText: NSString = searchBar.text as? NSString else { return true }
        
        let typedText = searchText.replacingCharacters(in: range, with: text)
        let range = typedText.range(of: model.matchRegExp, options: .regularExpression)
        
        let shouldChangeText = (range != nil && range?.isEmpty == false)
        if shouldChangeText {
            searchTextPublisher.send(typedText)
        }
        return shouldChangeText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchTextPublisher.send("")
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func configureTableView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
                
        let constraits = [
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
        ]
        
        NSLayoutConstraint.activate(constraits)
        
        self.tableView = tableView
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.id)
        tableView.rowHeight = 40.0
        tableView.estimatedRowHeight = 0.0
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = CityCell.id
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! CityCell
        let city = model.city(at: indexPath)
        cell.configure(model: city)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.citiesCount
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCity = model.city(at: indexPath) {
            addSearchToHistory()
            goToWeatherDetails?(selectedCity)
        }
    }
}
