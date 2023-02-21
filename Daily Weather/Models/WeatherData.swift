//
//  Weather.swift
//  Daily Weather
//
//  Created by Quasar on 20.07.2022.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let info: WeatherInfo
    let weather: [WeatherObject]
    enum CodingKeys: String, CodingKey {
        case name
        case info = "main"
        case weather
    }
}
