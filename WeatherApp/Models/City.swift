//
//  City.swift
//  WeatherApp
//
//  Created by denis.chicherin on 12.11.2019.
//  Copyright © 2019 ChiAppCompany. All rights reserved.
//

import Foundation


class City: NSObject, Codable {
    var name = ""
    var temp = 0
    var time = "00:00 PM"
    var weatherName = "Mist"
    var weatherDiscr = "some weather"
    var humidity = 0
    var windSpeed = 0
}
