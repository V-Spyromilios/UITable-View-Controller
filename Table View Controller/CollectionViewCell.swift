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
	static let identifier = "CollectionCellIdentifier"

	func configure(with country: CountryModel) {
	
		imageView.image = country.flagName
		//imageView.clipsToBounds = false
//		imageView.layer.cornerRadius = imageView.frame.height / 2
		print("Image height: \(String(describing: imageView.image?.size.height))")
		print("Image Width: \(String(describing: imageView.image?.size.width))")
		labelView.text = country.name
		labelView.font = UIFont(name: "Gill Sans Light Italic", size: 9)
		
	}
	
}
