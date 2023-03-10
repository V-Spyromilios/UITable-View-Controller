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
	
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		table.delegate = self
		table.dataSource = self
		
		collectionView.delegate = self
		collectionView.dataSource = self
		//				collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
		//		collectionView.collectionViewLayout = createLayout()
		
		self.navigationItem.title = "Countries"
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCountry))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleMovingRowEdit))
		self.navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
		self.navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
		table.rowHeight = 135
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
			if let indexPath = table.indexPathForSelectedRow {
				destinationDetailViewController.countryData = sortedCountries[indexPath.section][indexPath.row]
			}
		} else if let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController {
			destinationAddNewCountryParentViewController.onNewCountryAdded = {
				
				[weak self] in
				if let tabController = self?.tabBarController as? tabBarController,
				   let splitController = tabController.viewControllers?.first(where: { $0 is UISplitViewController }) as? UISplitViewController,
				   let navigationController = splitController.viewControllers.first(where: { $0 is UINavigationController }) as? UINavigationController,
				   let masterYoda = navigationController.viewControllers.first(where: { $0 is SplitMasterViewController}) as? SplitMasterViewController {
					
					tabController.tabBar.items?.first?.badgeValue = String(sortedCountries[0].count + sortedCountries[1].count)
					self?.table.reloadData()
					self?.collectionView.reloadData()
					masterYoda.tableView?.reloadData()
				}
			}
		}
	}
	
	func updateMasterTable() {
		// ARC ????
		
		if let tabController = self.tabBarController as? tabBarController,
		   let splitController = tabController.viewControllers?.first(where: { $0 is UISplitViewController }) as? UISplitViewController,
		   let navigationController = splitController.viewControllers.first(where: { $0 is UINavigationController }) as? UINavigationController,
		   let masterYoda = navigationController.viewControllers.first(where: { $0 is SplitMasterViewController}) as? SplitMasterViewController {
			masterYoda.tableView?.reloadData()
		}
	}
}


//MARK: Table Extensions...

extension TableAndCollectionViewController: UITableViewDelegate, UITableViewDataSource {
	
	//MARK: - Table cellForRowAt
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! CustomTableCell
		let country = sortedCountries[indexPath.section][indexPath.row]
		cell.updateCustomCell(with: country)
		
		return cell
	}
	
	//MARK: - Table didSelectRow()
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
		self.table.deselectRow(at: indexPath, animated: true)
	}
	
	//MARK:  Table Delete Row
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			sortedCountries[indexPath.section].remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
		let grandpa = self.parent?.parent as? tabBarController
		grandpa?.tabBar.items?[0].badgeValue = String(sortedCountries[0].count + sortedCountries[1].count)
		self.collectionView.reloadData()
		updateMasterTable()
		saveDataToJson()

	}
	
	//MARK: Table moveRowAt()
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
		//TODO: ADD "Action Not allowed" Warning
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return sortedCountries[section].count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 { return "EU" }
		else if section == 1 { return "LATIN AMERICA" }
		else { return nil }
	}
}

//MARK:  Collection Extensions
extension TableAndCollectionViewController: UICollectionViewDelegate {
	
	
	//MARK: Collection didSelectItemAt()
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath)
		let popupViewController =  self.storyboard?.instantiateViewController(withIdentifier: "PopUpStoryboardID") as! PopUpViewController
		popupViewController.countryData = sortedCountries[indexPath.section][indexPath.row]
		
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
		
		return sortedCountries[section].count
	}
	
	//MARK: Collection CellForItemAt
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let country = sortedCountries[indexPath.section][indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		
		cell.configure(with: country)
		return cell
	}
	
}
