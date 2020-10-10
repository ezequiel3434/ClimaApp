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
        
        let currentWeather = CurrentWeather()
        currentWeather.getCurrentWeather { (success) in
            if success {
                print("city is: ", currentWeather.city, currentWeather.currentTemp)
            }
        }
        
        
        
    }
    
    
    

}



