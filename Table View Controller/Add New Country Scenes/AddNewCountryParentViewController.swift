//
//  AddNewCountryParentViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.01.23.
//

import UIKit
import CoreData

class AddNewCountryParentViewController: UIViewController {
	
	@IBOutlet weak var OkButton: UIButton!
	
	var onNewCountryAdded: (() -> ())?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		OkButton.isEnabled = false
	}

	override func viewWillDisappear(_ animated: Bool) {
	
		onNewCountryAdded?()
	}
}
