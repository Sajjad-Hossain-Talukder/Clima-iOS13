//
//  WeatherManager.swift
//  Clima
//
//  Created by Xotech on 12/12/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//
import UIKit

struct WeatherManager {
    
    let weatherURL = "https://api.weatherapi.com/v1/current.json?key=60dd9ed4e39a4f81826113334231212&aqi=no&q="
    
    
    var delegate : WeatherProtocol?
    
    
    mutating func getTemp(_ location: String){
        let urlString = weatherURL+location
        self.performReq(urlString:urlString)
    }
    
    func performReq(urlString:String){
        let url = URL(string:urlString)
        if let safeURL = url {
            let session = URLSession(configuration: .default )
            let task = session.dataTask(with:safeURL, completionHandler: { (data,response,error) in
                if error != nil {
                    delegate?.encounteredError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weatherData = self.parseWeather(data: safeData) {
                        delegate?.updateWeather(cWeather: weatherData)
                    }
                }
                return
            } )
            task.resume()
        }
        // check below for details
    }
    
    
    
    func parseWeather( data: Data )->CurrentWeather? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDecoder.self, from : data )
            let cityName = decodedData.location.name
            let temp = decodedData.current.temp_c
            let code = decodedData.current.condition.code
           
            let currentWeather = CurrentWeather(city:cityName,temperature:temp,code:code)
            
            return currentWeather;
            
        } catch {
            delegate?.encounteredError(error: error)
            return nil
        }
        
    }
    
}



/*
 
 
 func updateTemp()->String {
 //return currentWeather!.temperature
 }
 
 func updateCity()->String {
 // return currentWeather!.city
 }
 
 handler(data:response:error:)
 //        let dataString = String(data: data, encoding: .utf8 )
 //        print(dataString)
 
 // func performRequest(urlString:String){
 //
 //        let url = URL ( string : urlString )
 //        // print(url)
 //        // create url
 //        if let safeURL = url {
 //            //url Session
 //            let session = URLSession(configuration: .default )
 //
 //            //session task
 //
 //            //Previous Task - using separate method
 //            //let task = session.dataTask(with:safeURL, completionHandler: handler( data: response: error:) )
 //            //Latest Task
 //
 let task = session.dataTask(with:safeURL, completionHandler: { (data,response,error) in
 if error != nil {
 print(error!)
 return
 }
 if let safeData = data {
 parseWeather(data: safeData)
 }
 return
 } )
 //
 ///*
    //            //Unreadable Version
    //            let task1 = session.dataTask(with:safeURL) {
    //                if $2 != nil {
    //                    print($2!)
    //                    return
    //                }
    //                if let safeData = $0 {
    //                    let dataString = String(data: safeData, encoding: .utf8 )
    //                    print(dataString!)
    //                }
    //
    //                return
    //            }
    // */
 //
 //            //resume url // start task - previous line initiate/config the task .. now we need to start it
 //
 //            task.resume()
 //        }
 //
 //    }
 */

/*
 func handler(data:Data? , response: URLResponse? ,error: Error? ){
 if error != nil {
 print(error!)
 return
 }
 if let safeData = data {
 let dataString = String(data: safeData, encoding: .utf8 )
 print(dataString!)
 }
 }
 
 
 if let safeURL = url {
 let session = URLSession(configuration: .default )
 let task = session.dataTask(with:safeURL, completionHandler:{ (data,response,error) in
 if error != nil {
 print(error!)
 return
 }
 if let safeData = data {
 self.parseWeather(data: safeData)
 }
 return
 } )
 task.resume()
 }
 */
