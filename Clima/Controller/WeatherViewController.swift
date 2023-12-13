//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        // permission for accessing GPS location from user
        locationManager.requestWhenInUseAuthorization()
        
        // Get the location
        locationManager.requestLocation()
    
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // Terminate keyboard from screen
        print(searchTextField.text!)
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
    // Enable Go/ Return Button from Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)  // Terminate keyboard from screen
        print(searchTextField.text!)
        return true
    }
    
    // after completing editing it activate. Here its said to clear the text in field
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something...."
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.getTempByCity(searchTextField.text!)
        searchTextField.text = ""
    }
    
}

//MARK: - Weather Protocol

extension WeatherViewController : WeatherProtocol {
    
    func updateWeather(cWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = cWeather.temperatureString
            self.cityLabel.text = cWeather.city
            self.conditionImageView.image = UIImage(systemName: cWeather.getCondition)
        }
    }
    
    func encounteredError(error: Error ){
        print( error )
    }
}

//MARK: - CLLocationManagerDelegate


extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            weatherManager.getTempByLatLon(lat:location.coordinate.latitude, lon:location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}





