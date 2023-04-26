//
//  SplitDetailViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 15.02.23.
//

import UIKit
import CoreData


class SplitMasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	static var delegate: SplitMasterDetailDelegate?
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			return CoreDataAssistant.intermediateCountries[0].count
		}
		else {
			return CoreDataAssistant.intermediateCountries[1].count
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU COUNTRIES" }
		else if section == 1 { return "NON EU COUNTRIES" }
		else { return nil }
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SplitMasterTableCell.identifier, for: indexPath) as!SplitMasterTableCell
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		
		cell.updateCustomCell(with: selectedCountry)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		
		if let detailVC = SplitMasterViewController.delegate as? SplitDetailViewController {
			
			detailVC.didSelectCountry(country: selectedCountry)
			splitViewController?.showDetailViewController(detailVC, sender: nil)
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	}
}


extension SplitMasterViewController: UISplitViewControllerDelegate {
	
	func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		
		if let detailVC = secondaryViewController as? SplitDetailViewController {
			if !detailVC.isCountrySet {
				return true
			}
		}
		return false
	}
	
	func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
		
		return .secondary
	}
}

