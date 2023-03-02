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

	var fetchedResultsController: NSFetchedResultsController<Country>!
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()

		setupFetchedResultsController()
		fetchedResultsController.delegate = self
		
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
			guard let indexPath = table.indexPathForSelectedRow else { return }
			let country = fetchedResultsController.object(at: indexPath)
			
			destinationDetailViewController.countryData = country
			
		} else if let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController {
			destinationAddNewCountryParentViewController.onNewCountryAdded = {
				
				[weak self] in
				if let tabController = self?.tabBarController as? tabBarController {
//				   let splitController = tabController.viewControllers?.first(where: { $0 is UISplitViewController }) as? UISplitViewController,
//				   let navigationController = splitController.viewControllers.first(where: { $0 is UINavigationController }) as? UINavigationController,
//				   let masterYoda = navigationController.viewControllers.first(where: { $0 is SplitMasterViewController}) as? SplitMasterViewController {
					
					tabController.tabBar.items?.first?.badgeValue = String((self?.fetchedResultsController.sections?[0].numberOfObjects ?? 0) +
																		   (self?.fetchedResultsController.sections?[1].numberOfObjects ?? 0))
					
					//					self?.table.reloadData()
					//					self?.collectionView.reloadData()
					//					masterYoda.tableView?.reloadData()
				}
			}
		}
	}
	
//	func updateMasterTable() {
//		// ARC ????
//		
//		if let tabController = self.tabBarController as? tabBarController,
//		   let splitController = tabController.viewControllers?.first(where: { $0 is UISplitViewController }) as? UISplitViewController,
//		   let navigationController = splitController.viewControllers.first(where: { $0 is UINavigationController }) as? UINavigationController,
//		   let masterYoda = navigationController.viewControllers.first(where: { $0 is SplitMasterViewController}) as? SplitMasterViewController {
//			masterYoda.tableView?.reloadData()
//		}
//	}
}


//MARK: Table Extensions...

extension TableAndCollectionViewController: UITableViewDelegate, UITableViewDataSource {
	
	//MARK: - Table cellForRowAt
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewCustomCell", for: indexPath) as! CustomTableCell
		let country = fetchedResultsController.object(at: indexPath) //  as? Country ?
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
		
		let country = fetchedResultsController.object(at: indexPath)
		let context = (UIApplication.shared.delegate as! AppDelegate).getCoreDataContext()
		
		if editingStyle == .delete {
			context.delete(country)
		}
		do {
			try context.save()
		} catch {
			print("PANIC: UITable DeleteRow :: context.save() Failed: \(error)")
		}
		let grandpa = self.parent?.parent as? tabBarController
		grandpa?.tabBar.items?[0].badgeValue = String((fetchedResultsController.sections?[0].numberOfObjects ?? 0) +
													  (fetchedResultsController.sections?[1].numberOfObjects ?? 0))
		self.collectionView.reloadData()
		//updateMasterTable()
	}
	
	//MARK: Table moveRowAt()
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		guard sourceIndexPath.section == destinationIndexPath.section else { return }
		
		let sectionIndex = sourceIndexPath.section
		var orderedSet = fetchedResultsController.sections?[sectionIndex].objects as? [Country]
		
		let removedCountry = orderedSet?.remove(at: Int(sourceIndexPath.row))
		orderedSet?.insert(removedCountry!, at: Int(destinationIndexPath.row))
		
		do {
			try fetchedResultsController.managedObjectContext.save()
		} catch {
			print("PANIC: tableView moveRowAt Failed to save(): \(error)")
		}
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
		
		if section == 0 {
			return fetchedResultsController.sections?[0].numberOfObjects ?? 0
		}
		else if section == 1 {
			return fetchedResultsController.sections?[0].numberOfObjects ?? 0
		}
		return 0
	}


	//MARK: Collection CellForItemAt
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let country = fetchedResultsController.object(at: indexPath)
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		
		cell.configure(with: country)
		return cell
	}
	
}

//MARK: NSFetchedResultsController

extension TableAndCollectionViewController: NSFetchedResultsControllerDelegate {

	private func setupFetchedResultsController() {
		
		let request : NSFetchRequest<Country> = Country.fetchRequest()
		let sorting = NSSortDescriptor(key: "name", ascending: true)
		request.sortDescriptors = [sorting]
		
		let euPredicate = NSPredicate(format: "euMember == YES")
		let othersPredicate = NSPredicate(format: "euMember == NO")
		
		let euFetchRequest = request
		euFetchRequest.predicate = euPredicate
		euFetchRequest.fetchBatchSize = 15
		euFetchRequest.fetchLimit = 50
		
		let othersFetchRequest = request
		othersFetchRequest.predicate = othersPredicate
		othersFetchRequest.fetchBatchSize = 15
		othersFetchRequest.fetchLimit = 40
		
		let context = (UIApplication.shared.delegate as! AppDelegate).getCoreDataContext()
		
		let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "euMember", cacheName: nil)
		self.fetchedResultsController = fetchedResultsController
		do {
			try fetchedResultsController.performFetch()
		} catch {
			print("PANIC: while 'try fetchedResultsController.performFetch()'. RETURNED \(error)")
		}
	}


	//Func of the Delegate triggered by
	func controller(_controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		
		switch type {
		case .delete:
			if let indexPath = indexPath {
				self.table.deleteRows(at: [indexPath], with: .bottom)
			}
		case .insert:
			table.insertRows(at: [newIndexPath!], with: .bottom)
		case .update:
			table.reloadRows(at: [indexPath!], with: .bottom)
		case .move:
			table.deleteRows(at: [indexPath!], with: .bottom)
			table.insertRows(at: [indexPath!], with: .middle)
		@unknown default:
			fatalError("PANIC: didChangeObject: Unhandled 'case'! Check Documentation for Updates in possible cases.")
		}
	}

	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

		self.table.beginUpdates()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

		switch type {
		case .insert:
			table.insertSections(IndexSet(integer: sectionIndex), with: .bottom)
		case .delete:
			table.deleteSections(IndexSet(integer: sectionIndex), with: .bottom)
		default:
			break
		}
	}

}
