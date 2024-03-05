//
//  SearchViewController.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import UIKit

class SearchViewController: UIViewController {

    var model: SearchViewModel!
    
    private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        configureSearchBar()
        
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
        
        searchBar.backgroundColor = .green
        searchBar.showsSearchResultsButton = true
        searchBar.placeholder = model.title
        searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let searchText: NSString = searchBar.text as? NSString else { return true }
        
        let typedText = searchText.replacingCharacters(in: range, with: text)
        let range = typedText.range(of: model.matchRegExp, options: .regularExpression)
        return (range != nil && range?.isEmpty == false)
    }
}
