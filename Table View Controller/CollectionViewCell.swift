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
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = imageView.frame.height / 2
		imageView.layer.borderColor = UIColor.gray.cgColor
		imageView.layer.borderWidth = 1
	}
	
	func configure(with country: CountryModel) {
		
		imageView.image = country.flagName
		
		labelView.text = country.name
		labelView.font = UIFont(name: "Gill Sans Light Italic", size: 10)
	}
	
}

/*
 func createLayout() -> UICollectionViewCompositionalLayout {
 
 let spacing: CGFloat = 30
 //  Item
 let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
 widthDimension: .fractionalWidth(1),
 heightDimension: .fractionalHeight(1)))
 item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
 print("Diamensions: \(item.layoutSize.heightDimension.dimension), \(item.layoutSize.widthDimension.dimension)")
 
 //  Group
 let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
 widthDimension: .fractionalWidth(1 / 4),
 heightDimension: .fractionalWidth(1 / 4)),
 repeatingSubitem: item,
 count: 4)
 
 // Sections
 let section = NSCollectionLayoutSection(group: horizontalGroup)
 
 // Return
 return UICollectionViewCompositionalLayout(section: section)
 }
 */
