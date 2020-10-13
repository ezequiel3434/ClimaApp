//
//  LocationService.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 13/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

class LocationService {
    static var shared = LocationService()
    
    var longitude: Double!
    var latitude: Double!
}
