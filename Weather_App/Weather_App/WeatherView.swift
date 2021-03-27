//
//  ContentView.swift
//  Weather_App
//
//  Created by Alexandre Genot on 27/03/2021.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack {
            Text("Paris")
                .font(.largeTitle)
                .padding()
            Text("14°C")
                .font(.system(size: 70))
                .bold()
            Text("⛅️")
                .font(.largeTitle)
                .padding()
            Text("Clear Sky")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
