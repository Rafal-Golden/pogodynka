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
    var tempColor: UIColor = .black
    var tempPerceivedTitle: String? = nil
    var tempPerceivedValue: String? = nil
    var pressureTitle: String? = nil
    var pressureValue: String? = nil
}

class DetailsViewModel {
    
    private var repository: WeatherRepositoryProtocol
    var iconImageDownloader: IconImageDownloader?
    
    var mapPoint: MapPoint
    var name: String
    var bgColor: UIColor
    var textColor: UIColor
    
    @Published var weather: WeatherViewModel?
    @Published var errorInfo: String?
    @Published var iconImage: UIImage?
    
    init(lat: Double, lon: Double, name: String, repository: WeatherRepositoryProtocol) {
        self.name = name
        self.mapPoint = MapPoint(lat: lat, lon: lon)
        self.bgColor = AppColors.background
        self.textColor = AppColors.body
        self.repository = repository
        self.weather = nil
        self.errorInfo = nil
    }
    
    func fetchWeather() {
        repository.getWeatherInfo(lat: mapPoint.lat, lon: mapPoint.lon) { [weak self] result in
            switch result {
                case .success(let weatherInfo):
                    self?.update(weatherInfo: weatherInfo, error: nil)
                case .failure(let error):
                    self?.update(weatherInfo: nil, error: error)
            }
        }
    }
    
    private func fetchWeatherIcon(name: String) {
        guard let downloader = self.iconImageDownloader else { return }
        
        downloader.download(iconName: name) { [weak self] image in
            self?.iconImage = image
        }
    }
    
    func update(weatherInfo: WeatherInfo?, error: NSError?) {
        if error != nil {
            self.errorInfo = NSLocalizedString("Sorry, We could not fetch data!. Please, try again.", comment: "")
#if DEBUG
            print("fetching weather info error \(error?.localizedDescription ?? "nil")")
#endif
        } else {
            self.errorInfo = nil
        }
        
        guard let weatherInfo else {
            self.weather = nil
            return
        }
        
        var weatherVM = WeatherViewModel()
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm dd/MM"
        weatherVM.dateString = NSLocalizedString("Weather now, at hour ", comment: "") + "\(formater.string(from: weatherInfo.dt))"
        formater.dateFormat = "HH:mm"
        weatherVM.sunset = formater.string(from: weatherInfo.sys.sunset)
        weatherVM.sunrise = formater.string(from: weatherInfo.sys.sunrise)
        weatherVM.temp = "\(weatherInfo.main.temp)°C"
        weatherVM.tempColor = tempColor(for: weatherInfo.main.temp.rounded())
        weatherVM.tempPerceivedTitle = NSLocalizedString("Perceived", comment: "")
        weatherVM.tempPerceivedValue = "\(weatherInfo.main.feelsLike)°C"
        weatherVM.pressureTitle = NSLocalizedString("Pressure", comment: "")
        weatherVM.pressureValue = "\(weatherInfo.main.pressure) hPa"
        
        weatherVM.description = weatherInfo.weather.first?.description
        
        if let weatherIcon = weatherInfo.weather.first?.icon {
            fetchWeatherIcon(name: weatherIcon)
        }
        
        self.weather = weatherVM
    }
    
    private func tempColor(for temp: Double) -> UIColor {
        return temp < 10.0 ? AppColors.tempBlue : (temp < 20.0 ? AppColors.tempBlack : AppColors.tempRed)
    }
}

extension DetailsViewModel {
    
    convenience init(city: CityModel, repository: WeatherRepositoryProtocol) {
        self.init(lat: city.lat, lon: city.lon, name: city.name, repository: repository)
    }
}
