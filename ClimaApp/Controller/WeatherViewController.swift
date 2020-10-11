//
//  ViewController.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 08/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast { (weeklyForecastArray) in
            for item in weeklyForecastArray {
                print("Forecast info: \(item.date) \(item.temp) \(item.weatherIcon)")
            }
        }
        
        
        
        
        
    }
    
    
    

}



