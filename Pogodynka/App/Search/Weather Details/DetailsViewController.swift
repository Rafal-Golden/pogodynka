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

        view.backgroundColor = .white
        setupUI()
        fetchWeather()
    }
    
    private let nameLabel = UILabel()
    private let weatherLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let perceivedTempLabel = UILabel()
    private let pressureLabel = UILabel()
    private let weatherImageView = UIImageView()
        
    func fetchWeather() {
        detailsModel.$weather.sink { [weak self] newWeather in
            self?.updateWeather(newWeather)
        }.store(in: &bucket)
        
        detailsModel.$errorInfo.sink { errorInfo in
            
        }.store(in: &bucket)
        
        detailsModel.fetchWeather()
    }
    
    func updateWeather(_ weather: WeatherViewModel?) {
        guard let weather else { return }
        
        nameLabel.text = detailsModel.name
        weatherLabel.text = "Pogoda teraz - dzisiaj godz. \(weather.dateString ?? "")"
        temperatureLabel.text = weather.temp
        perceivedTempLabel.text = weather.tempPerceivedValue
        pressureLabel.text = weather.pressureValue
        
        weatherImageView.image = UIImage()
    }
        
    private func setupUI() {
        nameLabel.font = .systemFont(ofSize: 32.0)
        temperatureLabel.font = .systemFont(ofSize: 40.0)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.backgroundColor = .purple.withAlphaComponent(0.25)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, weatherLabel, createWeatherStackView()])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60.0),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60.0),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createWeatherStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [weatherImageView, temperatureLabel, perceivedTempLabel, pressureLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }
}
