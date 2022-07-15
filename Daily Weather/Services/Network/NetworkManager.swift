//
//  NetworkManager.swift
//  Daily Weather
//
//  Created by Quasar on 15.07.2022.
//

import CoreLocation.CLLocation

//MARK: - NetworkManageable
protocol NetworkManagable: AnyObject {
    func fetch<T: Codable>(endpoint: Endpoint, type: T.Type, completion: (T) -> () )
}
