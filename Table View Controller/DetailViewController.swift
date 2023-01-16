//
//  ViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit

class DetailViewController: UIViewController {
	
	var countryData: CountryModel?
	
	@IBOutlet weak var countryNameLabel: UILabel!
	
	@IBOutlet weak var countryFlagImage: UIImageView!
	
	@IBOutlet weak var countryDescriptionTextView: UITextView!
	
	override func viewDidLoad() {

		super.viewDidLoad()
		setUpDetailView()
	}
	
	private func setUpDetailView() {
		guard let countryData = countryData else { return } //just checking if  'countryData'  is nil
		countryNameLabel.text = countryData.name
		countryNameLabel.font = UIFont(name: "Gill Sans", size: 24)
		countryFlagImage.image = UIImage(named: countryData.flagName ?? "")
		countryDescriptionTextView.text = countryData.description
	}
}
