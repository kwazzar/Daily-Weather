//
//  ViewController.swift
//  Daily Weather
//
//  Created by Quasar on 13.07.2022.
//

import UIKit
import CoreLocation.CLLocation

class WeatherViewController: UIViewController {

   private  let cancelButtonTitle = NSLocalizedString("Cancel", comment: "Alert cancel button")
    private let alertTextFieldPlaceholder = NSLocalizedString("Enter city name", comment: "Alert text field placeholder")
    private let alertSearchButton = NSLocalizedString("Search", comment: "Alert search button")
    
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var networkWeatherManager: NetworkManager!
    @IBOutlet private var locationManager: LocationManager!
    

    private let alertPlaceholders: [String] = [
    NSLocalizedString("San Francisco", comment: ""),
    NSLocalizedString("Kyiv", comment: ""),
    NSLocalizedString("New York", comment: ""),
    NSLocalizedString("Sydney", comment: ""),
    NSLocalizedString("Viena", comment: "")
    ]
    
            override func viewDidLoad() {
        super.viewDidLoad()
                
                activityIndicatorView.hidesWhenStopped = true
                
                setupLocation()

    }
    @IBAction func cancelUpdateLocation(_ sender: UIButton) {
 
        locationManager.manager.stopUpdatingLocation()
        activityIndicatorView.stopAnimating()
    }
}
//MARK: - Private API
    private extension WeatherViewController {
     
        func setupLocation() {
            locationManager.delegate = self
            locationManager.requestLocation()
        }
    
        func updateInterface(_ weather: Weather?) {
            activityIndicatorView.stopAnimating()
            
            guard let weather = weather else {
                return
            }

            cityLabel.text = weather.cityName
            temperatureLabel.text = weather.temperature
            feelsLikeTemperatureLabel.text = weather.temperature
            weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        let placeholder = alertPlaceholders.randomElement()
        let alertController = UIAlertController(title: alertTextFieldPlaceholder, message: "", preferredStyle: .alert)
        
//        let search = UIAlertAction(title: alertSearchButton, style: .default) { [weak self] action in
//            let alertText = alertController.textFields?.first(where: {$0.text != nil})
//            guard let cityName = alertText?.text else { return }
//            if cityName != "" {
//                self?.activityIndicatorView.startAnimating()
//                self?.networkWeatherManager.fetch(endpoint: .cityName(city: cityName), type: WeatherData.self) { [weak self] weather in
//
//                    self?.updateInterface(Weather(weather))
//            }
//        }
//        return
//                                          }
                                          
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        alertController.addAction(.init(title: cancelButtonTitle, style: .cancel, handler: nil))
        alertController.addAction(SearchAction(alertController: alertController))
        
        present(alertController, animated: true, completion: nil)
    }
    
        func SearchAction( alertController : UIAlertController ) -> UIAlertAction {
            let search = UIAlertAction(title: alertSearchButton, style: .default) { [weak self] action in
                let alertText = alertController.textFields?.first(where: {$0.text != nil})
                guard let cityName = alertText?.text else { return }
                if cityName != "" {
                    self?.activityIndicatorView.startAnimating()
                    self?.networkWeatherManager.fetch(endpoint: .cityName(city: cityName), type: WeatherData.self) { [weak self] weather in
                        
                        self?.updateInterface(Weather(weather))
                    }
                }
            }
            return search
        }
    }
//    func alertSearchAction(with text: String) -> UIAlertAction {
//        let action = UIAlertAction(title: alertSearchButton, style: .default) { [weak self] action in
//
//            guard let self = self,
//                  !text.isEmpty,
//                  let cityName = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//                      return
//                  }
//            self.activityIndicatorView.startAnimating()
//            self.networkWeatherManager.fetch(endpoint: .cityName(city: cityName), type: WeatherData.self) { [weak self] weather in
//
//                self?.updateInterface(Weather(weather))
//            }
//        }
//        return action
//    }
//
//}

//MARK: - LocationManagerDelegate
extension WeatherViewController: LocationManagerDelegate {
    
    func didUpdateLocations(coordinate: CLLocationCoordinate2D) {
        activityIndicatorView.startAnimating()
        
        networkWeatherManager.fetch(
            endpoint: .coordinate(coordinate),
            type: WeatherData.self)
        { [weak self] weather in
                
            self?.updateInterface(Weather(weather))
            }
    }
}
    
    
