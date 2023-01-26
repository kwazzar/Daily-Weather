//
//  Endpoint.swift
//  Daily Weather
//
//  Created by Quasar on 15.07.2022.
//

import CoreLocation.CLLocation

enum Endpoint {
    
    case cityName(city: String)
    case coordinate(CLLocationCoordinate2D)
    
    var path: String {
        switch self {
        case .cityName(_), .coordinate(_):
            return "/data/2.5/weather"
        }
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .cityName(let city):
            return [
            
                .init(name: "q", value: city),
                .init(name: "units", value: "metric")
            ]
        case .coordinate(let coordinate):
            return [
            
                .init(name: "lat", value:
                        coordinate.latitude.description),
                .init(name: "lon", value:
                        coordinate.longitude.description),
                .init(name: "units", value: "metric")
            ]
        }
    }
}
