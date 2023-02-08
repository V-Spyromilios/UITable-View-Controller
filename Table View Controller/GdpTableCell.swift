//
//  GdpTableCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class GdpTableCell: UITableViewCell {
	@IBOutlet weak var countryName: UILabel!
	
	static let identifier: String = "SplitViewTableCell"
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		self.countryName.font = UIFont(name: "George Rounded Bold Italic", size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func updateCustomCell(with country: CountryModel) {

		countryName.text = country.name
	}
}
