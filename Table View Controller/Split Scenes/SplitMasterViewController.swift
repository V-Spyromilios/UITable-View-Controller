//
//  SplitDetailViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 15.02.23.
//

import UIKit

class SplitMasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!


	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return sortedCountries[section].count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU" }
		else if section == 1 { return "LATIN AMERICA" }
		else { return nil }
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let country = sortedCountries[indexPath.section][indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SplitMasterTableCell.identifier, for: indexPath) as!SplitMasterTableCell
		
		cell.updateCustomCell(with: country)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let selectedCountry = sortedCountries[indexPath.section][indexPath.row]
		
		if let isCollapsed = splitViewController?.isCollapsed {
			if isCollapsed {
				let detailViewController =
				self.storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerID") as! SplitDetailController
				detailViewController.country = selectedCountry
				self.splitViewController?.showDetailViewController(detailViewController, sender: self)
			}
			else {
				let detailViewController = self.splitViewController?.viewControllers[1] as! SplitDetailController
				detailViewController.country = selectedCountry
				self.splitViewController?.showDetailViewController(detailViewController, sender: self)
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	}

	//MARK: Collapse Secondary
	func splitViewController(_ splitViewController: UISplitViewController,
							 collapseSecondary secondaryViewController: UISplitViewController,
							 onto primaryViewController: UISplitViewController) -> Bool {
		if let detailViewController = primaryViewController.viewControllers[1] as? SplitDetailController {
			if detailViewController.country == nil {
				return true
			}
		}
		return false
	}
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}


