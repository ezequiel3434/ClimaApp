//
//  GlobalHelpers.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 09/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import UIKit
func currentDateFromUnix(unixDate: Double?) -> Date? {
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else {
        return Date()
    }
}

func getWeatherIconFor(_ type: String) -> UIImage? {
    return UIImage(named: type)
}

func fahrenheitFrom(celcius: Double) -> Double {
    return (celcius * 9/5) + 32
}

func getTempBasedOnSettings(celcius: Double) -> Double {
    
    let format = returnTempFormatFromUserDefault()
    
    if format == TempFormat.celsius {
        return celcius
    } else {
        return fahrenheitFrom(celcius: celcius)
    }
}

func returnTempFormatFromUserDefault() -> String {
    if let tempFormat = UserDefaults.standard.value(forKey: "TempFormat") {
        if tempFormat as! Int == 0 {
            return TempFormat.celsius
        } else {
            return TempFormat.fahrenheit
        }
        
    } else {
        return TempFormat.celsius
    }
}


