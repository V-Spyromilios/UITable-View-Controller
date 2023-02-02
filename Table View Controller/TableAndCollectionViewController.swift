//
//  NewCustomViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 24.01.23.
//

import UIKit

class TableAndCollectionViewController: UIViewController, UIPopoverPresentationControllerDelegate {
	
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sortedCountries[section].count
	}
	
	//MARK: - cellForRowAt, dequeueReusable
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! NewCustomCell
		let country = sortedCountries[indexPath.section][indexPath.row]
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
		
		collectionView.delegate = self
		collectionView.dataSource = self
		//		collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		//		collectionView.collectionViewLayout = createLayout()
		
		self.navigationItem.title = "Countries!"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		table.rowHeight = 135
		
	}
	
	@objc func toggleMovingRowEdit() {
		self.table.isEditing = !self.table.isEditing
		if table.isEditing {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleMovingRowEdit))
		} else {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		}
	}
	
	@objc func addCountry() {
		
		self.performSegue(withIdentifier: "addNewCountrySegue", sender: self)
	}
	
	//MARK: - Moving Rows
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
			let selectedCountry = sortedCountries[0].remove(at: (sourceIndexPath.row))
			sortedCountries[destinationIndexPath.section].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else if sourceIndexPath.section == 1 && destinationIndexPath.section == 1 {
			let selectedCountry = sortedCountries[1].remove(at: (sourceIndexPath.row))
			sortedCountries[1].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else { return }
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU" }
		else if section == 1 { return "LATIN AMERICA" }
		else { return nil }
	}
	
	//MARK: - Delete Table Row
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			sortedCountries[indexPath.section].remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	//MARK: - TableView didSelectRow -> Segues
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
		self.table.deselectRow(at: indexPath, animated: true)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destinationDetailViewController = segue.destination as? DetailViewController {
			if let indexPath = table.indexPathForSelectedRow {
				destinationDetailViewController.countryData = sortedCountries[indexPath.section][indexPath.row]
			}
		} else if let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController {
			destinationAddNewCountryParentViewController.onNewCountryAdded = {
				[weak self] in
				self?.table.reloadData()
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 70, height: 70)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		
		return 30
	}
}

extension TableAndCollectionViewController: UITableViewDelegate, UITableViewDataSource {
	
}


//MARK: - CollectionViewDelegate
extension TableAndCollectionViewController: UICollectionViewDelegate {
	
	//MARK: -Collection didSelectItemAt -> PerformSegue
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath)
		let popupViewController =  self.storyboard?.instantiateViewController(withIdentifier: "PopUpStoryboardID") as! PopUpViewController
		popupViewController.countryData = sortedCountries[indexPath.section][indexPath.row]
		
		popupViewController.modalTransitionStyle = .coverVertical
		popupViewController.popoverPresentationController?.delegate = self
		popupViewController.popoverPresentationController?.sourceView = cell
		popupViewController.popoverPresentationController?.sourceRect = cell!.bounds
		present(popupViewController, animated: true, completion: nil )
		self.collectionView.deselectItem(at: indexPath, animated: true)
		//performSegue(withIdentifier: "popUpSegue", sender: cell)
	}
}

extension TableAndCollectionViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		2
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return sortedCountries[section].count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let country = sortedCountries[indexPath.section][indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
		
		cell.configure(with: country)
		return cell
	}
}

extension TableAndCollectionViewController: UICollectionViewDelegateFlowLayout {
	
}
