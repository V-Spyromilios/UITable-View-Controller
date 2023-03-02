//
//  GdpTableCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class SplitMasterTableCell: UITableViewCell {
	
	@IBOutlet weak var countryNameLabel: UILabel!
	
	static let identifier: String = "SplitViewTableCell"
	override func awakeFromNib() {
        super.awakeFromNib()

		self.countryNameLabel.font = UIFont(name: "George Rounded Bold Italic", size: 18)
    }

	func updateCustomCell(with country: Country) {

		countryNameLabel.text = country.name
	}
}
