//
//  NewCustomViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 24.01.23.
//

import UIKit

///Delegate and DataSource into extension!!!
class NewCustomViewController: UIViewController {
	
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var collection: UICollectionView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries[section].count
	}
	
	//MARK: - cellForRowAt, dequeueReusable
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! NewCustomCell
		let country = countries[indexPath.section][indexPath.row]
		cell.updateCustomCell(with: country)
		
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	//MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.delegate = self
		table.dataSource = self

		collection.delegate = self
		collection.dataSource = self

		self.navigationItem.title = "Countries!"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		table.rowHeight = 135
	}
	
	@objc func toggleMovingRowEdit() {
		self.table.isEditing = !self.table.isEditing
		if table.isEditing {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleMovingRowEdit))
		}
		else {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		}
	}
	
	@objc func addCountry() {
		
		self.performSegue(withIdentifier: "addNewCountrySegue", sender: self)
	}
	
	//MARK: - Moving Rows
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
			let selectedCountry = countries[0].remove(at: (sourceIndexPath.row))
			countries[destinationIndexPath.section].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else if sourceIndexPath.section == 1 && destinationIndexPath.section == 1 {
			let selectedCountry = countries[1].remove(at: (sourceIndexPath.row))
			countries[1].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else {
			return
		}
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU" }
		else if section == 1 { return "LATIN AMERICA" }
		else { return nil }
	}
	
	//MARK: - Delete row, reloadData
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			countries[indexPath.section].remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	//MARK: - didSelectRow -> Segue to DetailView
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destinationDetailViewController = segue.destination as? DetailViewController {
			if let indexPath = table.indexPathForSelectedRow {
				let selectedRow = indexPath.row
				destinationDetailViewController.countryData = countries[indexPath.section][selectedRow]
			}
		}
		guard let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController  else { return }
		destinationAddNewCountryParentViewController.delegate = self
	}
}

extension NewCustomViewController: UITableViewDelegate, UITableViewDataSource {

}

extension NewCustomViewController: reloadTableProtocol {
	
	func reloadTable() {
		table.reloadData()
	}
}

extension NewCustomViewController: UICollectionViewDelegate {
	
}

extension NewCustomViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return countries[section].count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let country = countries[indexPath.section][indexPath.row]
		let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionCellIdentifier", for: indexPath) as! CollectionViewCell

		cell.configure(with: country)
		return cell
	}
	
	
}

extension NewCustomViewController: UICollectionViewDelegateFlowLayout {
	
}
