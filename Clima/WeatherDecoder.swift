//
//  WeatherDecoder.swift
//  Clima
//
//  Created by Xotech on 12/12/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

struct WeatherDecoder : Decodable {
    let current : Temperature
    let location : Name
}

struct Temperature: Decodable  {
    let temp_c : Double
    let condition : Condition
}

struct Condition : Decodable {
    let text : String
    let code : Int
}

struct Name : Decodable {
    let name : String
}
