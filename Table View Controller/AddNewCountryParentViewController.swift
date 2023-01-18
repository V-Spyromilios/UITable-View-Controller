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
	
	
	//MARK: - Navigation
	
	//    // In a storyboard-based application, you will often want to do a little preparation before navigation
	//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	//		if segue.identifier == "segueToAddCountryTable" {
	//			let childViewController = segue.destination as? AddCountryTableViewController
	//			newCountry?.name = childViewController?.countryNameField.text ?? "Default from Segue"
	//			newCountry?.description = childViewController?.countryDescriptionField.text ?? "Default from Segue"
	//			newCountry?.euMember = (childViewController?.isEuMemberSwitch.isOn) == true
	//			if newCountry?.name != nil {
	//				if ((newCountry?.euMember) != false) {
	//					countries[0].append(newCountry!)
	//				}
	//				else  {
	//					countries[1].append(newCountry!)
	//				}
	//				let parentViewController = self.parent as? UITableViewController
	//				parentViewController?.tableView.reloadData()
	//			}
	//		}
	//    }
	
	
}
