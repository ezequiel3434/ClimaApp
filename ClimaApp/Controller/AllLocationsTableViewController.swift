//
//  AllLocationsTableViewController.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 12/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class AllLocationsTableViewController: UITableViewController {
    
    //MARK: - Vars
    
    var savedLocations: [WeatherLocation]?
    let userDefaults = UserDefaults.standard
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserDefaults()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    //MARK: - UserDefaults
    private func loadFromUserDefaults(){
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            savedLocations = try? PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)

        }
        print("number: \(savedLocations?.count)")
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
        print("We have added new location", newLocation.country, newLocation.city)
    }
    
    
}
