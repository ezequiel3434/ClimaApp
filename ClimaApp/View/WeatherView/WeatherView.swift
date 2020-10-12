//
//  WeatherView.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 11/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    //MARK: - IBOulets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Vars
    var currentWeather: CurrentWeather!
    var weeklyWeatherForecastData: [WeeklyWeatherForecast] = []
    var dailyWeatherForecastData: [HourlyForecast] = []
    var weatherInfoData: [WeatherInfo] = []
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        mainInit()
    }
    
    private func mainInit(){
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupTableView()
        setupInfoCollectionView()
        setupHourlyCollectionView()
    }

    private func setupTableView(){
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    private func setupHourlyCollectionView(){
        hourlyCollectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        hourlyCollectionView.dataSource = self
    }
    
    private func setupInfoCollectionView(){
        infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        infoCollectionView.dataSource = self
    }
    
    func refreshData() {
        setupCurrentWeather()
        setupWeatherInfo()
        infoCollectionView.reloadData()
    }
    
    private func setupCurrentWeather(){
        cityNameLabel.text = currentWeather.city
        dateLabel.text = "Today, \(currentWeather.date.shortDate())"
        weatherInfoLabel.text = currentWeather.weatherType
        tempLabel.text = "\(currentWeather.currentTemp)"
    }
    
    private func setupWeatherInfo() {
        let windInfo = WeatherInfo(infoText: String.init(format: "%.1f m/s", currentWeather.windSpeed), nameText: nil, image: getWeatherIconFor("wind"))
        let humidityInfo = WeatherInfo(infoText: String.init(format: "%.0f", currentWeather.humedity), nameText: nil, image: getWeatherIconFor("humidity"))
        let pressureInfo = WeatherInfo(infoText: String.init(format: "%.0f mb", currentWeather.pressure), nameText: nil, image: getWeatherIconFor("pressure"))
        let sunriseInfo = WeatherInfo(infoText: currentWeather.sunrise, nameText: nil, image: getWeatherIconFor("sunrise"))
        let sunsetInfo = WeatherInfo(infoText: currentWeather.sunset, nameText: nil, image: getWeatherIconFor("sunset"))
        let visibilityInfo = WeatherInfo(infoText: String.init(format: "%.0f km", currentWeather.visibility), nameText: nil, image: getWeatherIconFor("visibility"))
        let feelslikeInfo = WeatherInfo(infoText: String.init(format: "%.1f", currentWeather.feelsLike), nameText: nil, image: getWeatherIconFor("feelslike"))
        let uvInfo = WeatherInfo(infoText: String.init(format: "%.1f", currentWeather.uv), nameText: "UV Index", image: nil)
        
        weatherInfoData = [windInfo, humidityInfo, pressureInfo, sunriseInfo, sunsetInfo, visibilityInfo, feelslikeInfo, uvInfo]
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WeatherView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        cell.generateCell(forecast: weeklyWeatherForecastData[indexPath.row])
        return cell
    }
    
    
    
}

//MARK: - UICollectionViewDataSource
extension WeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == hourlyCollectionView {
            
            return dailyWeatherForecastData.count
        } else {
            return weatherInfoData.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hourlyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ForecastCollectionViewCell
            cell.generateCell(weather: dailyWeatherForecastData[indexPath.row])
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InfoCollectionViewCell
            cell.generateCell(weatherInfo: weatherInfoData[indexPath.row])
            return cell
        }
    }
    
    
}
