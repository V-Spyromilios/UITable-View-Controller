//
//  GdpTableController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class SplitMasterController: UITableViewController {
	
	@IBOutlet var table: UITableView!

	static var delegate: splitCountryProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.delegate = self
		table.dataSource = self

		//		self.navigationItem.title = "GDP"
		self.navigationItem.style = .browser
		self.title = "Countries List"

	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return sortedCountries[section].count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU" }
		else if section == 1 { return "LATIN AMERICA" }
		else { return nil }
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let country = sortedCountries[indexPath.section][indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: SplitMasterTableCell.identifier, for: indexPath) as!SplitMasterTableCell
		
		cell.updateCustomCell(with: country)
		
		return cell
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let selectedCountry = sortedCountries[indexPath.section][indexPath.row]
//		let detailViewController = storyboard?.instantiateViewController(withIdentifier: "splitDetail") as! SplitSecondaryViewController

		if let detailViewController = SplitMasterController.delegate as? SplitDetailController {
			splitViewController?.showDetailViewController(detailViewController, sender: self)
			SplitMasterController.delegate?.sendCountryToDetailView(country: selectedCountry)
		}

//		performSegue(withIdentifier: "splitDetail", sender: nil)
//		splitViewController?.setViewController(detailViewController, for: .secondary)
//		splitViewController?.showDetailViewController(detailViewController, sender: nil)
	}
	
	
	// MARK: - Navigation
	
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//		if let indexPath = table.indexPathForSelectedRow {
//			let selectedCountry = sortedCountries[indexPath.section][indexPath.row]
//
//			if let navigationController = segue.destination as? UINavigationController {
//				let detailController = navigationController.topViewController as? SplitSecondaryViewController
//				detailController?.country = selectedCountry
//			}
//		}
//	}
}
