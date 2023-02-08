//
//  GdpTableController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class GdpTableController: UITableViewController {
	
	@IBOutlet var table: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.delegate = self
		table.dataSource = self
		
		//		self.navigationItem.title = "GDP"
		self.navigationItem.style = .browser
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
		
		let cell = tableView.dequeueReusableCell(withIdentifier: GdpTableCell.identifier, for: indexPath) as!GdpTableCell
		
		cell.updateCustomCell(with: country)
		
		return cell
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
//		let detailViewController = storyboard?.instantiateViewController(withIdentifier: "splitDetail") as! SplitSecondaryViewController

		performSegue(withIdentifier: "splitDetail", sender: nil)
//		splitViewController?.setViewController(detailViewController, for: .secondary)
//		splitViewController?.showDetailViewController(detailViewController, sender: nil)
	}
	
	
	// MARK: - Navigation
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let indexPath = table.indexPathForSelectedRow {
			let selectedCountry = sortedCountries[indexPath.section][indexPath.row]
			
			if let navigationController = segue.destination as? UINavigationController {
				let detailController = navigationController.topViewController as? SplitSecondaryViewController
				detailController?.country = selectedCountry
			}
		}
	}
}
