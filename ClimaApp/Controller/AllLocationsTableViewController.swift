//
//  AllLocationsTableViewController.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 12/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
protocol AllLocationsTableViewControllerDelegate {
    func didChooseLocation(atIndex: Int, shouldRefresh: Bool)
}

class AllLocationsTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tempSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var footerView: UIView!
    
    
    
    //MARK: - Vars
    
    var savedLocations: [WeatherLocation]?
    let userDefaults = UserDefaults.standard
    var weatherData: [CityTempData]?
    
    var delegate: AllLocationsTableViewControllerDelegate?
    var shouldRefresh = false
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserDefaults()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func tempSegmentValueChange(_ sender: UISegmentedControl) {
        print("selected: \(sender.selectedSegmentIndex)")
        
        updateTempFormatInUserDefaults(newValue: sender.selectedSegmentIndex)
    }
    
    //MARK: - UserDefaults
    
    private func updateTempFormatInUserDefaults(newValue: Int){
        shouldRefresh = true
        userDefaults.set(newValue, forKey: "TempFormat")
        userDefaults.synchronize()
        
    }
    
    private func loadTempFormatFromUserDefaults() {
        if let index = userDefaults.value(forKey: "TempFormat") {
            tempSegmentOutlet.selectedSegmentIndex = index as! Int
        } else {
            tempSegmentOutlet.selectedSegmentIndex = 0
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherData?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainWeatherTableViewCell
        
        if weatherData != nil {
            cell.generateCell(weatherData: weatherData![indexPath.row])
            
        }
        return cell
    }
    
    //MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didChooseLocation(atIndex: indexPath.row, shouldRefresh: shouldRefresh)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locationToDelete = weatherData?[indexPath.row]
            weatherData?.remove(at: indexPath.row)
            
            removeLocationFromSavedLocation(location: locationToDelete!.city)
            
            tableView.reloadData()
        }
    }
    
    private func removeLocationFromSavedLocation(location: String) {
        if savedLocations != nil {
            for i in 0..<savedLocations!.count {
                let tempLocation = savedLocations![i]
                if tempLocation.city == location {
                    savedLocations?.remove(at: i)
                    saveNewLocationsToUserDefaults()
                    return
                }
            }
        }
    }
    
    
    
    //MARK: - UserDefaults
    private func loadFromUserDefaults(){
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            savedLocations = try? PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
            
        }
        
    }
    
    private func saveNewLocationsToUserDefaults(){
        
        shouldRefresh = true
        userDefaults.set(try? PropertyListEncoder().encode(savedLocations!), forKey: "Locations")
        userDefaults.synchronize()
    }
    
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseLocationSeg" {
            let vc = segue.destination as! ChooseCityViewController 
            vc.delegate = self
            
        }
    }
    
}






//MARK: - ChooseCityViewControllerDelegate

extension AllLocationsTableViewController: ChooseCityViewControllerDelegate {
    
    func didAdd(newLocation: WeatherLocation) {
        shouldRefresh = true
        weatherData?.append(CityTempData(city: newLocation.city , temp: 0.0))
        tableView.reloadData()
    }
    
    
}
