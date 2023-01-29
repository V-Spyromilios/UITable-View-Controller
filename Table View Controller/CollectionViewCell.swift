//
//  CollectionViewCell.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 29.01.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	
	@IBOutlet weak var labelView: UILabel!
	let identifier = "CollectionCellIdentifier"

	func configure(with country: CountryModel) {
		imageView.image = country.flagName
		labelView.text = country.name
		labelView.font = UIFont(name: "Gill Sans Light Italic", size: 8)
		
	}
	
}
