//
//  CustomViewCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 23.01.23.
//

import UIKit

class CustomCell: UITableViewCell {

	@IBOutlet weak var flagImageView: UIImageView!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var countryDescriptionLabel: UILabel!
	@IBOutlet weak var countryGdpLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		
    }

	func updateCustomCell(with country: CountryModel) {

		self.countryNameLabel.text = country.name
		self.countryDescriptionLabel.text = country.description
		self.flagImageView.image = country.flagName
		if country.gdp != nil {
			self.countryGdpLabel.text = "$\(country.gdp!)"
		}
	}
}
