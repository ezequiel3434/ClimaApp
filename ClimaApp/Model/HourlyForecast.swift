//
//  HourlyForecast.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 10/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HourlyForecast {
    private var _date: Date!
    private var _temp: Double!
    private var _weatherIcon: String!
    
    // getters
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        
        let json = JSON(weatherDictionary)
        self._temp = getTempBasedOnSettings(celcius: json["temp"].double ?? 0.0) 
        self._date = currentDateFromUnix(unixDate: json["ts"].double!)
        self._weatherIcon = json["weather"]["icon"].stringValue
    }
    
    
    static func downloadHourlyForecastWeather(location: WeatherLocation, completion: @escaping(_ hourlyForecast: [HourlyForecast])->Void) {
        
        
        
        var HOURLYFORECAST_URL: String!
        
        if !location.isCurrentLocation {
            HOURLYFORECAST_URL = String(format: "https://api.weatherbit.io/v2.0/forecast/hourly?city=%@,%@&hours=24&key=7c1909634a1c40259418c967a63191a4", location.city.replacingOccurrences(of: " ", with: "+").toNoSmartQuotes(), location.countryCode)
        } else {
            HOURLYFORECAST_URL = CURRENTLOCATIONHOURLYFORECAST_URL
        }
        
        AF.request(HOURLYFORECAST_URL).responseJSON { (response) in
            
            let result = response.result
            var forecastArray: [HourlyForecast] = []
            switch result {
                
            case .success(let value):
                
                
                if let dictionary = value as? Dictionary<String, AnyObject> {
                    if let list = dictionary["data"] as? [Dictionary<String,AnyObject>] {
                        for item in list {
                            let forecast = HourlyForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completion(forecastArray)
            case .failure(let error):
                completion(forecastArray)

                print("no forecast data with error: \(error)")
            }
        }
        
    }
    
}
