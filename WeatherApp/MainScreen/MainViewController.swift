//
//  MainViewController.swift
//  WeatherApp
//
//  Created by denis.chicherin on 12.11.2019.
//  Copyright © 2019 ChiAppCompany. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var cityList = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city1 = City()
        city1.name = "London"
        city1.time = "12:11 AM"
        city1.weatherName = "Mist"
        city1.weatherDiscr = "Туман - чё тут ещё..."
        city1.humidity = 75
        city1.windSpeed = 2
        cityList.append(city1)
    }
    
    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
}

