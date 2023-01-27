//
//  AddNewCountryParentViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.01.23.
//
/// Delegate and Closure for below,
/// Std Collection Views!! like Ikea: Countries. PopUp instead of DetailView. To be shrink according to data.
import UIKit

class AddNewCountryParentViewController: UIViewController {
	weak var delegate: reloadTableProtocol?
	
	@IBOutlet weak var OkButton: UIButton!
	var newCountry = CountryModel(name: "", description: "", euMember: false)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		OkButton.isEnabled = false
	}

	//MARK: - Reload Table Data at viewWillDisappear
	override func viewWillDisappear(_ animated: Bool) {
		delegate?.reloadTable()
	}
}
