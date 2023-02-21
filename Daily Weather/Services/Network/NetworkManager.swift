//
//  NetworkManager.swift
//  Daily Weather
//
//  Created by Quasar on 15.07.2022.
//

import CoreLocation.CLLocation

// MARK: - NetworkManageable

protocol NetworkManagable: AnyObject {
    func fetch<T: Codable>(endpoint: Endpoint, type: T.Type, completion: @escaping (T) -> Void )
}

// MARK: - NetworkManager

final class NetworkManager: NSObject, NetworkManagable {

    private let decoder = JSONDecoder()
    private lazy var apiBaseUrlPath: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
    return apiBaseURL
    }()

    func fetch<T: Codable>(endpoint: Endpoint, type: T.Type, completion: @escaping (T) -> Void ) {
        var urlComponents = URLComponents()
        urlComponents.host = apiBaseUrlPath
        urlComponents.scheme = "https"
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        urlComponents.queryItems?.append(.init(name: "apikey", value: kOpenweathermapKey))
        performRequest(url: urlComponents.url, type: type, completion: completion)
    }

    private func performRequest<T: Codable> (url: URL?, type: T.Type, completion: @escaping (T) -> Void ) {
        guard let url = url else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [unowned self] data, response, error in
            if let data = data,
                let decodedObject = try? self.decoder.decode(type, from: data) {
                DispatchQueue.main.async {
                    completion(decodedObject)
                }
            }
    }
        task.resume()
}
}
