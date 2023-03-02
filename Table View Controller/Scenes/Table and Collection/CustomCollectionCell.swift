//
//  CollectionViewCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 29.01.23.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	
	@IBOutlet weak var labelView: UILabel!
	static let identifier = "CollectionCellIdentifier"
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = imageView.frame.height / 2
		imageView.layer.borderColor = UIColor.gray.cgColor
		imageView.layer.borderWidth = 1
	}
	
	func configure(with country: Country) {
		
		if let flagImage = UIImage(contentsOfFile: country.flagPath!) {
			imageView.image = flagImage

			labelView.text = country.name
			labelView.font = UIFont(name: "Gill Sans Light Italic", size: 10)
		}
	}
}
