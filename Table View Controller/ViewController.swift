//
//  ViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit

class ViewController: UIViewController {
	
	var countryData: CountryModel = CountryModel(name: "", description: "", image: "", euMember: false)
	
	@IBOutlet weak var countryNameLabel: UILabel!
	
	@IBOutlet weak var countryFlagImage: UIImageView!
	
	@IBOutlet weak var countryDescriptionTextView: UITextView!
	
	override func viewDidLoad() {

		super.viewDidLoad()
		countryNameLabel.text 				= countryData.name
		countryFlagImage.image 				= UIImage(named: countryData.flag ?? "")
		countryDescriptionTextView.text 	= countryData.description
		
		// Do any additional setup after loading the view.
	}
}
		
