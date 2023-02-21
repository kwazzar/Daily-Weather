//
//  LocationManager.swift
//  Daily Weather
//
//  Created by Quasar on 21.07.2022.
//

import CoreLocation
import UIKit.UIApplication

 // MARK: - LocationManagerDelegete

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocations(coordinate: CLLocationCoordinate2D)
}

// MARK: - Location

protocol Location: AnyObject {
    var delegate: LocationManagerDelegate? { get set }
    func requestLocation()
}

// MARK: - LocationManager

class LocationManager: NSObject, Location {
    weak var delegate: LocationManagerDelegate?
     let manager: CLLocationManager
    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        super.init()
        manager.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        }
    deinit {
        NotificationCenter.default.removeObserver(self)
}

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
     }
}

@objc extension LocationManager {
    private func applicationDidBecomeActive() {
        requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let coordinate = location.coordinate
        delegate?.didUpdateLocations(coordinate: coordinate)
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
