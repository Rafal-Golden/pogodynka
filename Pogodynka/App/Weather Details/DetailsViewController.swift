//
//  DetailsViewController.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    var goBackBlock: (() -> Void)?
    var detailsModel: DetailsViewModel!
    private var bucket = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = detailsModel.bgColor
        setupUI()
        fetchWeather()
    }
    
    private let nameLabel = UILabel()
    private let weatherLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let tempDescriptionLabel = UILabel()
    private let perceivedTempLabel = UILabel()
    private let perceivedTitleLabel = UILabel()
    private let pressureLabel = UILabel()
    private let pressureTitleLabel = UILabel()
    private let weatherImageView = UIImageView()
        
    func fetchWeather() {
        detailsModel.$weather.sink { [weak self] newWeather in
            self?.updateWeather(newWeather)
        }.store(in: &bucket)
        
        detailsModel.$errorInfo.sink { [weak self] errorInfo in
            self?.weatherLabel.text = errorInfo
        }.store(in: &bucket)
        
        detailsModel.$iconImage.sink { [weak self] iconImage in
            self?.weatherImageView.image = iconImage
        }.store(in: &bucket)
        
        detailsModel.fetchWeather()
    }
    
    func updateWeather(_ weather: WeatherViewModel?) {
        guard let weather else { return }
        
        nameLabel.text = detailsModel.name
        weatherLabel.text = weather.dateString
        temperatureLabel.text = weather.temp
        tempDescriptionLabel.text = weather.description
        perceivedTempLabel.text = weather.tempPerceivedValue
        pressureLabel.text = weather.pressureValue
        pressureTitleLabel.text = weather.pressureTitle
        perceivedTitleLabel.text = weather.tempPerceivedTitle
        temperatureLabel.textColor = weather.tempColor
        
        weatherImageView.backgroundColor = weather.tempColor.withAlphaComponent(0.1)
        weatherImageView.layer.cornerRadius = 10
        weatherImageView.clipsToBounds = true
        nameLabel.backgroundColor = weatherImageView.backgroundColor
        nameLabel.layer.cornerRadius = 8
        nameLabel.clipsToBounds = true
    }
        
    private func setupLabels() {
        let labels = [nameLabel, weatherLabel, temperatureLabel, tempDescriptionLabel, perceivedTempLabel, pressureTitleLabel, pressureLabel, perceivedTitleLabel]
        for label in labels {
            label.textColor = detailsModel.textColor
        }
        
        nameLabel.font = .systemFont(ofSize: 32.0)
        temperatureLabel.font = .systemFont(ofSize: 40.0)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.backgroundColor = .clear
        
        weatherLabel.numberOfLines = 0
        weatherLabel.lineBreakMode = .byWordWrapping
    }
    
    private func setupUI() {
        
        setupLabels()
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, weatherLabel, createWeatherStackView(), createPerceivedStackView(), createPressureStackView()])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60.0),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60.0),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        addMapView(mapPoint: detailsModel.mapPoint, topAnchor: stackView.bottomAnchor)
    }
    
    private func createHStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }
    
    private func createPressureStackView() -> UIStackView {
        return createHStackView(views: [pressureTitleLabel, pressureLabel])
    }
    
    private func createWeatherStackView() -> UIStackView {
        return createHStackView(views: [weatherImageView, createTempStackView()])
    }
    
    private func createVStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        
        return stackView
    }
    
    private func createTempStackView() -> UIStackView {
        return createVStackView(views: [tempDescriptionLabel, temperatureLabel])
    }
    
    private func createPerceivedStackView() -> UIStackView {
        return createHStackView(views: [perceivedTitleLabel, perceivedTempLabel])
    }
}
