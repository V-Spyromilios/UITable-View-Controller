//
//  NewCustomCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 24.01.23.
//

import UIKit

class NewCustomCell: UITableViewCell {

	@IBOutlet weak var countryDescriptionLabel: UILabel!
	@IBOutlet weak var countryGdpLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var countryImageView: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func updateCustomCell(with country: CountryModel) {

		self.countryNameLabel.text = country.name
		self.countryNameLabel.font = UIFont(name: "George Rounded Bold Italic", size: 27)
		self.countryDescriptionLabel.text = country.description
		self.countryImageView.image = country.flagName
		if country.gdp != nil {
			self.countryGdpLabel.text = "$\(country.gdp!)"
			self.countryGdpLabel.font = UIFont(name: "Gill Sans Italic", size: 15)
		}
	}

}
