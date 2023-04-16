//
//  SwTableViewCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 21.03.23.
//

import UIKit

class SwTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var detailLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

	func updateCustomSwCell(with movie: Movie) {

		self.titleLabel.text = movie.title
		self.detailLabel.text = movie.releaseDate
		
		self.titleLabel.textColor = UIColor(named: "SwYellow")
		self.detailLabel.textColor = UIColor.gray

		self.titleLabel.font = UIFont(name: "SF Distant Galaxy", size: 15)
		self.detailLabel.font = UIFont(name: "GillSans", size: 12)
	}
}
