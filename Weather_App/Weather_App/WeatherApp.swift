//
//  WeatherApp.swift
//  Weather_App
//
//  Created by Alexandre Genot on 27/03/2021.
//

import SwiftUI

@main

struct WeatherApp: App {
    var body: some Scene{
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)
        }
    }
}
