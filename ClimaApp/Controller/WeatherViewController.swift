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
        
        HourlyForecsast.downloadHourlyForecastWeather { (hourlyForecastArray) in
            for data in hourlyForecastArray {
                print("forecast data: \(data.temp) \(data.date) \(data.weatherIcon)")
            }
        }
        
        
        
    }
    
    
    

}



