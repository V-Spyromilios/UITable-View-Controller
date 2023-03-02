//
//  SplitDetailViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 15.02.23.
//

import UIKit


class SplitMasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	
	static var delegate: SplitMasterDetailDelegate?
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			return fetchedResultsController.sections?[0].numberOfObjects ?? 0
		}
		else if section == 1 {
			return fetchedResultsController.sections?[0].numberOfObjects ?? 0
		}
		return 0
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
			if detailVC.country == nil {
				return true
			}
		}
		return false
	}
	
	func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
		
		return .secondary
	}
}
