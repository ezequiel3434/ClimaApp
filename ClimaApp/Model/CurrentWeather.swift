//
//  CurrentWeather.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 09/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    private var _city: String!
    private var _date: Date!
    private var _currentTemp: Double!
    private var _feelsLike: Double!
    private var _uv: Double!
    
    private var _weatherType: String!
    private var _pressure: Double! //mb
    private var _humedity: Double! //%
    private var _windSpeed: Double! // meter/sec
    private var _weatherIcon: String!
    private var _visibility: Double! // KM
    private var _sunrise: String!
    private var _sunset: String!
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        
        return _city
    }
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        
        return _date
    }
    var uv: Double {
        if _uv == nil {
            _uv = 0.0
        }
        
        return _uv
    }
    
    var sunrise: String {
        if _sunrise == nil {
            _sunrise = ""
        }
        
        return _sunrise
    }
    
    var sunset: String {
        if _sunset == nil {
            _sunset = ""
        }
        
        return _city
    }
    
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }

    var feelsLike: Double {
           if _feelsLike == nil {
            _feelsLike = 0.0
           }
           
           return _feelsLike
       }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    var pressure: Double {
        if _pressure == nil {
            _pressure = 0.0
        }
        
        return _pressure
    }
    var humedity: Double {
        if _humedity == nil {
            _humedity = 0.0
        }
        
        return _humedity
    }
    var windSpeed: Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        
        return _windSpeed
    }
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        
        return _weatherIcon
    }
    var visibility: Double {
        if _visibility == nil {
            _visibility = 0.0
        }
        
        return _visibility
    }
    
    static func getCurrentWeather() {
        let LOCATIONAPI_URL = "https://api.weatherbit.io/v2.0/current?city=Mendoza,AR&key=7c1909634a1c40259418c967a63191a4"
        
        AF.request(LOCATIONAPI_URL).responseJSON { (response) in
            let result = response.result
            
            switch result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                break
            case .failure(let error):
                print("No result for current Location with error: \(error)")
                break
            
            }
        }
        
    }
}
