//
//  NewCustomViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 24.01.23.
//

import UIKit
import CoreData

class TableAndCollectionViewController: UIViewController, UIPopoverPresentationControllerDelegate {
	
	@IBOutlet weak var table: UITableView!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
	
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.delegate = self
		table.dataSource = self
		collectionView.delegate = self
		collectionView.dataSource = self
		
		self.table.reloadData()
		
		self.navigationItem.title = "Countries"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		self.navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
		self.navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
		table.rowHeight = 135
		
		let counter = CoreDataAssistant.intermediateCountries[0].count + (CoreDataAssistant.intermediateCountries[1].count)
		print("ViewDidLoad COUNTER: \(counter)")
		let grandpa = self.parent?.parent as? tabBarController
		grandpa?.tabBar.items?.first?.badgeValue = String((CoreDataAssistant.intermediateCountries[0].count ) + (CoreDataAssistant.intermediateCountries[1].count))
	}
	
	@objc func toggleMovingRowEdit() {
		
		self.table.isEditing = !self.table.isEditing
		if table.isEditing {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toggleMovingRowEdit))
			self.navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
		} else {
			self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
			self.navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
		}
	}
	
	@objc func addCountry() {
		
		self.performSegue(withIdentifier: "addNewCountrySegue", sender: self)
	}
	
	//MARK: - PrepareForSegue()
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
		if let destinationDetailViewController = segue.destination as? DetailViewController {
			guard let indexPath = table.indexPathForSelectedRow else { return }
			
			let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
			destinationDetailViewController.countryData = selectedCountry
			
		} else if let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController {
			
			destinationAddNewCountryParentViewController.onNewCountryAdded = {
				[weak self] in
				CoreDataAssistant.intermediateCountries = CoreDataAssistant.loadCountries()
				self!.table.reloadData()
				self?.collectionView.reloadData()
				if let tabController = self?.tabBarController as? tabBarController {
					
					tabController.tabBar.items?.first?.badgeValue = String((CoreDataAssistant.intermediateCountries[0].count ) + (CoreDataAssistant.intermediateCountries[1].count ))
				}
			}
		}
	}
}


//MARK: Table Extensions...

extension TableAndCollectionViewController: UITableViewDelegate, UITableViewDataSource {
	
	//MARK: - Table cellForRowAt
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! CustomTableCell
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		cell.updateCustomCell(with: selectedCountry)
		
		return cell
	}
	
	//MARK: - Table didSelectRow()
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
		self.table.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK:  Table Delete Row
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		
		if editingStyle == .delete {
			CoreDataAssistant.intermediateCountries[indexPath.section].remove(at: indexPath.row)
			CoreDataAssistant.context.delete(selectedCountry)
		}
		CoreDataAssistant.saveContext()
		do {
			try CoreDataAssistant.fetchedResultsController.performFetch()
		} catch { print("PANIC: performFetch() of Delete Table Row") }
		CoreDataAssistant.intermediateCountries = CoreDataAssistant.loadCountries()
		self.table.reloadData()
		self.collectionView.reloadData()
		
		let grandpa = self.parent?.parent as? tabBarController
		grandpa?.tabBar.items?.first?.badgeValue = String((CoreDataAssistant.intermediateCountries[0].count ) + (CoreDataAssistant.intermediateCountries[1].count))
		//updateMasterTable()
	}
	
	//MARK: Table moveRowAt()
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		if sourceIndexPath.section == 0 && destinationIndexPath.section == 0 {
			let selectedCountry = CoreDataAssistant.intermediateCountries[0].remove(at: (sourceIndexPath.row))
			CoreDataAssistant.intermediateCountries[destinationIndexPath.section].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else if sourceIndexPath.section == 1 && destinationIndexPath.section == 1 {
			let selectedCountry = CoreDataAssistant.intermediateCountries[1].remove(at: (sourceIndexPath.row))
			CoreDataAssistant.intermediateCountries[1].insert(selectedCountry, at: destinationIndexPath.row)
		}
		else { return }
		
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 0 {
			return CoreDataAssistant.intermediateCountries[0].count
		}
		else {
			return CoreDataAssistant.intermediateCountries[1].count
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		
		if section == 0 {
			return "EU Countries"
		} else {
			return "Non EU Countries"
		}
	}
}

//MARK:  Collection Extensions
extension TableAndCollectionViewController: UICollectionViewDelegate {
	
	
	//MARK: Collection didSelectItemAt()
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath)
		
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		
		
		let popupViewController =  self.storyboard?.instantiateViewController(withIdentifier: "PopUpStoryboardID") as! PopUpViewController
		
		popupViewController.countryData = selectedCountry
		
		popupViewController.modalTransitionStyle = .crossDissolve
		popupViewController.view.backgroundColor = UIColor(displayP3Red: 60, green: 60, blue: 60, alpha: 0.7)
		popupViewController.modalPresentationStyle = .overCurrentContext
		popupViewController.popoverPresentationController?.delegate = self
		popupViewController.popoverPresentationController?.sourceView = cell
		popupViewController.popoverPresentationController?.sourceRect = cell!.bounds
		
		present(popupViewController, animated: true, completion: nil)
		self.collectionView.deselectItem(at: indexPath, animated: true)
	}
	
	// MARK: Collection sizeForItemAt()
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 70, height: 70)
	}
	
	//MARK: Collection interimSpacingForSectionAt()
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		
		return 10
	}
}


//MARK: Collection numberOfSections & numberOfItemsInSection
extension TableAndCollectionViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if section == 0 {
			return CoreDataAssistant.intermediateCountries[0].count
		}
		else {
			return CoreDataAssistant.intermediateCountries[1].count
		}
	}
	
	
	//MARK: Collection CellForItemAt
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let selectedCountry = CoreDataAssistant.intermediateCountries[indexPath.section][indexPath.row]
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		
		cell.configure(with: selectedCountry)
		return cell
	}
	
}
