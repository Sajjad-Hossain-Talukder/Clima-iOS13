//
//  WeatherDecoder.swift
//  Clima
//
//  Created by Xotech on 12/12/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

struct WeatherDecoder : Decodable {
    let main : Main
    let weather : [Weather]
    let name  : String
}

struct Main: Decodable  {
    let temp : Double
}

struct Weather : Decodable {
    let id : Int
}

