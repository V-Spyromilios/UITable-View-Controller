//
//  NewCustomViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 24.01.23.
//

import UIKit

class NewCustomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var table: UITableView!
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! NewCustomCell
		let country = countries[indexPath.section][indexPath.row]
		cell.updateCustomCell(with: country)
		cell.showsReorderControl = true
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			return "EU"
		}
		else if section == 1 {
			return "LATIN AMERICA"
		}
		else { return nil }
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
	}
	
	//MARK: - Delete row, reloadData
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			countries[indexPath.section].remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			self.table.reloadData()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let indexPath = table.indexPathForSelectedRow {
			let selectedRow = indexPath.row
			guard let destinationViewController = segue.destination as? DetailViewController else { return }
			destinationViewController.countryData = countries[indexPath.section][selectedRow]
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.dataSource = self
		table.delegate = self
		
		self.navigationItem.title = "Countries!"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTable))
	}
	
	@objc func refreshTable() {
		
		self.table.reloadData()
	}
	
	@objc func addCountry() {
		
		self.performSegue(withIdentifier: "addNewCountrySegue", sender: self)
	}
	
}
