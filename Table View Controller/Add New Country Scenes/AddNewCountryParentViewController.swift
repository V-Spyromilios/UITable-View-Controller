//
//  AddNewCountryParentViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.01.23.
//

import UIKit

class AddNewCountryParentViewController: UIViewController {
	
	@IBOutlet weak var OkButton: UIButton!
	var newCountry = CountryModel(name: "", description: "", flag: nil, euMember: false, gdp: nil, location: defaultLocation)
	
	var onNewCountryAdded: (() -> ())?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		OkButton.isEnabled = false
	}

	//MARK: - Reload Table Data at viewWillDisappear
	override func viewWillDisappear(_ animated: Bool) {
	
		onNewCountryAdded?()
		saveDataToJson()
	}
}
