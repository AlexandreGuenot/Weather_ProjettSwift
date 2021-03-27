//
//  WeatherService.swift
//  Weather_App
//
//  Created by Alexandre Genot on 27/03/2021.
//

import Foundation
import CoreLocation

public final class WeatherService : NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "5be398991759d4d2d18c422f50391c15"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates : CLLocationCoordinate2D) {
        guard let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) else {return}
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something Went Wrong: \(error.localizedDescription)")
    }
}
struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}
struct APIMain: Decodable
{
    let temp: Double
}
struct APIWeather: Decodable
{
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
