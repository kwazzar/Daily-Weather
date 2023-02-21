//
//  Weather.swift
//  Daily Weather
//
//  Created by Quasar on 20.07.2022.
//

import Foundation

struct Weather {
    let cityName: String
    let temperature: String
    let feelsLikeTemperature: String
    private let weatherType: Int
    var systemIconNameString: String {
        switch weatherType {
        case 200...232: return "cloud.boly.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }

    init?(_ weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = String(format: "%.0f", weatherData.info.temp)
        feelsLikeTemperature = String(format: "%.0f", weatherData.info.feelsLike)
        weatherType = weatherData.weather.first?.weatherType ?? 0
    }
}
