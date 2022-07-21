//
//  ViewController.swift
//  Daily Weather
//
//  Created by Quasar on 13.07.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

   private  let cancelButtonTitle = NSLocalizedString("Cancel", comment: "Alert cancel button")
    private let alertTextFieldPlaceholder = NSLocalizedString("Enter city name", comment: "Alert text field placeholder")
    private let alertSearchButton = NSLocalizedString("Search", comment: "Alert search button")
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet var networkWeatherManager: NetworkManager!
    
    @IBOutlet var locationManager: LocationManager!
    

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
        let alertText = alertController.textFields?.first?.text ?? ""
        
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        alertController.addAction(.init(title: cancelButtonTitle, style: .cancel, handler: nil))
        alertController.addAction(alertSearchAction(with: alertText))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func alertSearchAction(with text: String) -> UIAlertAction {
        let action = UIAlertAction(title: alertSearchButton, style: .default) { [weak self] action in
            
            guard let self = self,
                  !text.isEmpty,
                  let cityName = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                      return
                  }
            self.activityIndicatorView.startAnimating()
            self.networkWeatherManager.fetch(endpoint: .CityName(city: cityName), type: WeatherData.self) { [weak self] weather in
                
                self?.updateInterface(Weather(weather))
            }
        }
        return action
    }
    
}

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
    

