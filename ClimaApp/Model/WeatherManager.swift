//
//  WeatherManager.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 08/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherManager: NSObject  {
    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        print("\(long) | \(lat)")
    }
    
   
    
}

extension WeatherManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
}


