//
//  MainViewController.swift
//  WeatherApp
//
//  Created by denis.chicherin on 12.11.2019.
//  Copyright © 2019 ChiAppCompany. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, AddNewCityVCDelegate {
    
    var cityList = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city1 = City()
        city1.name = "London"
        city1.temp = 46
        city1.time = "12:11 AM"
        city1.weatherName = "Sunny"
        city1.weatherDiscr = "Pizdec kak zharko..."
        city1.humidity = 10
        city1.windSpeed = 2
        cityList.append(city1)
    }
    
    // MARK:- Add Item ViewController Delegates
    func addNewCityVCDidCancel(_ controller: NewCityViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addNewCityVC(_ controller: NewCityViewController, didFinishAdding city: City) {
        let newRowIndex = cityList.count
        cityList.append(city)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath) as! CityTableViewCell
        let city = cityList[indexPath.row]
        cell.city = city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    // MARK:- Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCity" {
            let controller = segue.destination as! NewCityViewController
            controller.delegate = self
        }
    }
}

