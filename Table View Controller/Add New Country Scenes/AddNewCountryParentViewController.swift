//
//  AddNewCountryParentViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.01.23.
//

import UIKit

class AddNewCountryParentViewController: UIViewController {
	let context = (UIApplication.shared.delegate as? AppDelegate)?.getCoreDataContext()
	
	@IBOutlet weak var OkButton: UIButton!
	lazy var newCountry = Country(context: context!)
	
	var onNewCountryAdded: (() -> ())?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		OkButton.isEnabled = false
	}

	override func viewWillDisappear(_ animated: Bool) {
	
		onNewCountryAdded?()
	}
}
