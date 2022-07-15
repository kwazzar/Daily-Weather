//
//  ViewController.swift
//  Daily Weather
//
//  Created by Quasar on 13.07.2022.
//

import UIKit

class WeatherViewController: UIViewController {

   private  let cancelButtonTitle = NSLocalizedString("Cancel", comment: "Alert cancel button")
    private let alertTextFieldPlaceholder = NSLocalizedString("Enter city name", comment: "Alert text field placeholder")
    private let alertSearchButton = NSLocalizedString("Search", comment: "Alert search button")
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let alertPlaceholders: [String] = [
    NSLocalizedString("San Francisco", comment: ""),
    NSLocalizedString("Kyiv", comment: ""),
    NSLocalizedString("New York", comment: ""),
    NSLocalizedString("Sydney", comment: ""),
    NSLocalizedString("Viena", comment: "")
    ]
    
            override func viewDidLoad() {
        super.viewDidLoad()

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
        }
        return action
    }
    
}

