//
//  WeatherObject.swift
//  Daily Weather
//
//  Created by Quasar on 20.02.2023.
//

import Foundation

struct WeatherObject: Codable {
    let weatherType: Int
    enum CodingKeys: String, CodingKey {
        case weatherType = "id"
    }
}
