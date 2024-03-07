//
//  DetailsModel.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 07/03/2024.
//

import UIKit
import Combine

struct WeatherViewModel {
    var dateString: String? = nil
    var sunrise: String? = nil, sunset: String? = nil
    var description: String? = nil
    var temp: String? = nil
    var tempPerceivedTitle: String? = nil
    var tempPerceivedValue: String? = nil
    var pressureTitle: String? = nil
    var pressureValue: String? = nil
    var weatherIcon: String? = nil
}

class DetailsViewModel {
    
    private var repository: WeatherRepositoryProtocol
    
    var lat: Double, lon: Double
    var name: String
    var bgColor: UIColor
    
    @Published var weather: WeatherViewModel?
    @Published var errorInfo: String?
    
    init(lat: Double, lon: Double, name: String, repository: WeatherRepositoryProtocol) {
        self.lat = lat
        self.lon = lon
        self.name = name
        self.bgColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        self.repository = repository
        self.weather = nil
        self.errorInfo = nil
    }
    
    func fetchWeather() {
        repository.getWeatherInfo(lat: lat, lon: lon) { [weak self] result in
            switch result {
                case .success(let weatherInfo):
                    self?.update(weatherInfo: weatherInfo, error: nil)
                case .failure(let error):
                    self?.update(weatherInfo: nil, error: error)
            }
        }
    }
    
    func update(weatherInfo: WeatherInfo?, error: NSError?) {
        self.errorInfo = error?.localizedDescription
        
        guard let weatherInfo else {
            self.weather = nil
            return
        }
        
        var weatherVM = WeatherViewModel()
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm dd/MM"
        weatherVM.dateString = formater.string(from: weatherInfo.dt)
        formater.dateFormat = "HH:mm"
        weatherVM.sunset = formater.string(from: weatherInfo.sys.sunset)
        weatherVM.sunrise = formater.string(from: weatherInfo.sys.sunrise)
        weatherVM.temp = "\(weatherInfo.main.temp)°C"
        weatherVM.tempPerceivedTitle = "Odczuwalna"
        weatherVM.tempPerceivedValue = "\(weatherInfo.main.feelsLike)°C"
        weatherVM.pressureTitle = "Ciśnienie"
        weatherVM.pressureValue = "\(weatherInfo.main.pressure) hPa"
        
        weatherVM.description = weatherInfo.weather.first?.description
        
        self.weather = weatherVM
    }
}

extension DetailsViewModel {
    
    convenience init(city: CityModel, repository: WeatherRepositoryProtocol) {
        self.init(lat: city.lat, lon: city.lon, name: city.name, repository: repository)
    }
}
