//
//  APIURLS.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 12/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

let CURRENTLOCATION_URL = "https://api.weatherbit.io/v2.0/current?&lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&key=7c1909634a1c40259418c967a63191a4"
let CURRENTLOCATIONWEEKLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&days=7&key=7c1909634a1c40259418c967a63191a4"
let CURRENTLOCATIONHOURLYFORECAST_URL = "https://api.weatherbit.io/v2.0/forecast/hourly?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&hours=24&key=7c1909634a1c40259418c967a63191a4"
