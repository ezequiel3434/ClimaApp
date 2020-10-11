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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let weatherView = WeatherView()
        scrollContentView.addSubview(weatherView)
        
        
        weatherView.frame = CGRect(x: 0, y: 0, width: scrollContentView.bounds.width, height: scrollContentView.bounds.height)
        
        weatherScrollView.addSubview(scrollContentView)
    }
    
    
    
}



