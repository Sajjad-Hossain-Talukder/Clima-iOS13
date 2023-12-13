//
//  CurrentWeather.swift
//  Clima
//
//  Created by Xotech on 12/12/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

struct CurrentWeather {
    let city : String
    let temperature : Double
    let code : Int
    
    var temperatureString : String {
        return String(format:"%0.1f",temperature)
    }
    
    var getCondition : String {
        switch code {
        case 1000...1030:
            return "cloud.bolt"
        case 1031...1050:
            return "cloud.drizzle"
        case 1051...1080:
            return "cloud.rain"
        case 1081...1100:
            return "cloud.snow"
        case 1101...1140:
            return "cloud.fog"
        case 1141...1200:
            return "sun.max"
        case 1201...1250:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
}
