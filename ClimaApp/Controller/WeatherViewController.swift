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
    
    //MARK: - IBOulets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollContentView: UIView!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
               
    }
    
    //MARK: - Download Weather
    
    private func getCurrentWeather(weatherView: WeatherView){
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView){
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast { (weatherForecasts) in
            weatherView.weeklyWeatherForecastData = weatherForecasts
            weatherView.refreshData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView){
        HourlyForecast.downloadHourlyForecastWeather { (weatherForecasts) in
            weatherView.dailyWeatherForecastData = weatherForecasts
        }
    }

    
    
}



