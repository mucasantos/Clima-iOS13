//
//  WeatherData.swift
//  Clima
//
//  Created by Samuel Santos on 15/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: Array<Weather> // or [Weather]
}

struct Main: Decodable {
    let temp: Double
    let pressure: Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
