//
//  WeatherInfo.swift
//  Daily Weather
//
//  Created by Quasar on 20.02.2023.
//

import Foundation

struct WeatherInfo: Codable {
    let temp: Double
    let feelsLike: Double
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}
