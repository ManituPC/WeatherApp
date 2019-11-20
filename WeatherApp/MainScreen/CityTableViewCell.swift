//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by denis.chicherin on 20.11.2019.
//  Copyright © 2019 ChiAppCompany. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherNameLabel: UILabel!
    @IBOutlet weak var weatherDescrLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var city: City? {
        didSet {
            cityNameLabel.text = city?.name
            degreesLabel.text = String(describing: city?.temp)
            timeLabel.text = city?.time
            weatherNameLabel.text = city?.weatherName
            weatherDescrLabel.text = city?.weatherDiscr
            windSpeedLabel.text = String(describing: city?.windSpeed)
            humidityLabel.text = String(describing: city?.humidity)
        }
    }
}
