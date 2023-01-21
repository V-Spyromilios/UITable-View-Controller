//
//  AddNewCountryParentViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.01.23.
//

import UIKit

class AddNewCountryParentViewController: UIViewController {
	
	@IBOutlet weak var OkButton: UIButton!
	var newCountry = CountryModel(name: "", description: "", euMember: false)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		OkButton.isEnabled = false
		
		// Do any additional setup after loading the view.
	}
	
	
	
	//MARK: - Reload Table Data at viewWillDisappear
	
	override func viewWillDisappear(_ animated: Bool) {
		let rootViewController = self.presentingViewController
		let tableViewController = rootViewController?.children[0] as? TableController
		tableViewController?.tableView.reloadData()
	}
}
