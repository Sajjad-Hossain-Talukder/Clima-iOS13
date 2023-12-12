//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITextFieldDelegate {
    
    var weatherManager = WeatherManager()
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // Terminate keyboard from screen
        print(searchTextField.text!)
    }
    
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
        weatherManager.getTemp(searchTextField.text!)
        temperatureLabel.text = weatherManager.updateTemp()
        cityLabel.text = weatherManager.updateCity()
        searchTextField.text = ""
    }
    
}

