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
        
        loadCityList()
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
        
        saveCityList()
    }
    
    func addNewCityVC(_ controller: NewCityViewController, didFinishEditing city: City) {
        if let index = cityList.firstIndex(of: city) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell as! CityTableViewCell, with: city)
            }
        }
        navigationController?.popViewController(animated: true)
        
        saveCityList()
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
        } else if segue.identifier == "EditCity" {
            let controller = segue.destination as! NewCityViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.cityToEdit = cityList[indexPath.row]
            }
        }
    }
    
    // MARK: - Read and write data
    
    func documentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("WeatherApp.plist")
    }
    
    func saveCityList() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(cityList)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadCityList() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                cityList = try decoder.decode([City].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Other
    
    func configureText(for cell: CityTableViewCell, with city: City) {
        if let label = cell.cityNameLabel {
            label.text = city.name
        }
    }
}

