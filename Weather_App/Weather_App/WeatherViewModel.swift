//
//  WeatherViewModel.swift
//  Weather_App
//
//  Created by Alexandre Genot on 27/03/2021.
//

import Foundation

private let DefaultIcon = "?"
private let iconMap = [
    "Drizzle" : "🌧",
    "ThunderStorm" : "⛈",
    "Clouds" : "☁️",
    "Rain" : "🌧",
    "Snow" : "🌨",
    "Clear" : "☀️",
]
public class WeatherViewModel : ObservableObject {
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = DefaultIcon
    
    public let weatherService: WeatherService
    
    public init (weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    public func refresh () {
        weatherService.loadWeatherData{weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? DefaultIcon
            }
        }
    }
}
