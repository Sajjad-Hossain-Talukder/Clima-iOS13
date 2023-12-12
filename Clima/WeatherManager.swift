//
//  File.swift
//  Clima
//
//  Created by Xotech on 12/12/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//
import UIKit

struct WeatherManager {
    
    let weatherURL = "https://api.weatherapi.com/v1/current.json?key=60dd9ed4e39a4f81826113334231212&aqi=no&q="
    var currentWeather : CurrentWeather?
    
    mutating func getTemp(_ location: String){
        let urlString = weatherURL+location
        self.performReq(urlString:urlString)
    }
    
    mutating func performReq(urlString:String){
        let url = URL(string:urlString)
        if let safeURL = url {
            let session = URLSession(configuration: .default )
            let task = session.dataTask(with:safeURL, completionHandler: self.handler(data:response:error:) )
            task.resume()
        }
        // check below for details
    }
    
    mutating func handler(data:Data? , response: URLResponse? ,error: Error? ){
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            self.parseWeather(data: safeData)
            //let dataString = String(data: safeData, encoding: .utf8 )
            //print(dataString!)
        }
        return
    }
    
    
    mutating func parseWeather( data: Data ){
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDecoder.self, from : data )
            currentWeather = CurrentWeather(city:decodedData.location.name, temperature: String(format:"%0.1f",decodedData.current.temp_c), condition: decodedData.current.condition.text)
    
        } catch {
           print(error)
       }
//        let dataString = String(data: data, encoding: .utf8 )
//        print(dataString)
    }
    
    func updateTemp()->String {
        return currentWeather!.temperature
    }
    
    func updateCity()->String {
        return currentWeather!.city
    }
    

}



/*
 
 
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
//            let task = session.dataTask(with:safeURL, completionHandler: { (data,response,error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    parseWeather(data: safeData)
               }
//
//                return
//            } )
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
