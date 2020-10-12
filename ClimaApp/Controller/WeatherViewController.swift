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
    
    //MARK: - Vars
    var weatherLocation: WeatherLocation!
    
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let weatherView = WeatherView()
        weatherView.frame = CGRect(x: 0, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
        weatherScrollView.addSubview(weatherView)
        
        weatherLocation = WeatherLocation(city: "Guaymallen", country: "Argentina", countryCode: "AR", isCurrentLocation: false)
        
        getCurrentWeather(weatherView: weatherView)
        getWeeklyWeather(weatherView: weatherView)
        getHourlyWeather(weatherView: weatherView)
               
    }
    
    //MARK: - Download Weather
    
    private func getCurrentWeather(weatherView: WeatherView){
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather(location: weatherLocation) { (success) in
            weatherView.refreshData()
        }
    }
    
    private func getWeeklyWeather(weatherView: WeatherView){
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: weatherLocation) { (weatherForecasts) in
            weatherView.weeklyWeatherForecastData = weatherForecasts
            
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView){
        HourlyForecast.downloadHourlyForecastWeather(location: weatherLocation) { (weatherForecasts) in
            
            weatherView.dailyWeatherForecastData = weatherForecasts
            
            weatherView.hourlyCollectionView.reloadData()
        }
    }

    
    
}



