//
//  ViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit
import PhotosUI

class DetailViewController: UIViewController {
	
	var countryData: Country?
	
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var countryGdpLabel: UILabel!
	
	@IBOutlet weak var countryFlagImage: UIImageView!
	
	@IBOutlet weak var countryDescriptionTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpDetailView()
		self.view.backgroundColor = .white
	}
	
	private func setUpDetailView() {
		guard let countryData = countryData else { return } //just checking if  'countryData'  is nil
		countryNameLabel.text = countryData.name.uppercased()
		guard let customFont = UIFont(name: "George Rounded Bold Italic", size: 25) else {
			fatalError("""
 Failed to load the "George Rounded Semibold Italic" font.
 Make sure the font file is included in the project and the font name is correct.
 """)
		}
		countryNameLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
		countryNameLabel.adjustsFontForContentSizeCategory = true

		countryGdpLabel.text = "Gross Domestic Product: $\(countryData.gdp)"
		countryGdpLabel.font = UIFont(name: "Gill Sans Light", size: 16)

		countryDescriptionTextView.text = countryData.countryDescription

		let flagImage = UIImage(contentsOfFile: countryData.flagPath)
		countryFlagImage.image = flagImage
		countryFlagImage.backgroundColor = .white
		countryFlagImage.layer.shadowColor = UIColor.systemGray2.cgColor
		countryFlagImage.clipsToBounds = false //to make shadow visible
		countryFlagImage.layer.shadowOpacity = 1.0
	}	
}
