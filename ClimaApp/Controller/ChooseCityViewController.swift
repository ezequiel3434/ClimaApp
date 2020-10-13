//
//  ChooseCityViewController.swift
//  ClimaApp
//
//  Created by Ezequiel Parada Beltran on 12/10/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit

class ChooseCityViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Vars
    var allLocations: [WeatherLocation] = []
    var filteredLocations: [WeatherLocation] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLocationsFromCSV()
    }
    
    //MARK: - Get Locations
    
    private func loadLocationsFromCSV() {
        if let path = Bundle.main.path(forResource: "location", ofType: "csv") {
            parseCSVAt(url: URL(fileURLWithPath: path))
        }
    }
    
    private func parseCSVAt(url: URL){
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                var i = 0
                for line in dataArr {
                    if line.count > 2 && i != 0 {
                        createLocation(line: line)
                    }
                    
                    i += 1
                }
            }
        } catch {
            print("Error reading CSV file, ", error.localizedDescription)
        }
    }
    
    private func createLocation(line: [String]){
        
        allLocations.append(WeatherLocation(city: line.first!, country: line.last!, countryCode: line[1], isCurrentLocation: false))
        
    }

}

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // save location
    }
    
    
}
