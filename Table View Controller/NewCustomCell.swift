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

		self.countryNameLabel.font = UIFont(name: "George Rounded Bold Italic", size: 27)
		self.countryGdpLabel.font = UIFont(name: "Gill Sans Italic", size: 15)

		self.countryImageView.layer.shadowColor = UIColor.gray.cgColor
		self.countryImageView.layer.shadowOpacity = 1.0
		self.countryImageView.clipsToBounds = true
		self.countryImageView.backgroundColor = .white

	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

	}
	
	func updateCustomCell(with country: CountryModel) {
		countryNameLabel.text = country.name
		countryDescriptionLabel.text = country.description

		countryImageView.image = country.flagName

		if let countryGdp = country.gdp { // Right Way to handle Optionals !
			countryGdpLabel.text = "$ \(countryGdp)"
		} else {
			countryGdpLabel.text = "-"
		}
		
	}
}
