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

//	lazy var fetchedResultsController: NSFetchedResultsController<Country> = {
//		let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
//		fetchRequest.sortDescriptors = [
//			NSSortDescriptor(key: "euMember", ascending: false),
//			NSSortDescriptor(key: "name", ascending: true)
//		]
//
//		// Use a custom keyPath to group the countries into two sections based on euMember attribute
//		let sectionKeyPath = #keyPath(Country.euMember)
//		let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
//													managedObjectContext: CoreDataAssistant.context,
//													sectionNameKeyPath: sectionKeyPath,
//													cacheName: nil)
//		do {
//			try controller.performFetch()
//		} catch {
//			print("PANIC: Fetch Request Failed: \(error)")
//		}
//		return controller
//	}()


	
	var countries = [[Country]]() //Empty instead of = [[]]
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		do {
			try CoreDataAssistant.fetchedResultsController.performFetch()
		} catch { print("PANIC: viewDidLoad :: performFetch() Failed -> \(error)") }
		self.table.reloadData()

		table.delegate = self
		table.dataSource = self
		
		CoreDataAssistant.fetchedResultsController.delegate = self
		
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
			
			//			let country = self.shared.fetchedResultsController.object(at: indexPath)
			let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: indexPath)
			
			destinationDetailViewController.countryData = selectedCountry
			
		} else if let destinationAddNewCountryParentViewController = segue.destination as? AddNewCountryParentViewController {
			
			destinationAddNewCountryParentViewController.onNewCountryAdded = {
				[weak self] in
				if let tabController = self?.tabBarController as? tabBarController {
					
					tabController.tabBar.items?.first?.badgeValue = String((CoreDataAssistant.fetchedResultsController.sections?[0].numberOfObjects)! +
																		   (CoreDataAssistant.fetchedResultsController.sections?[1].numberOfObjects)!)
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
		let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: indexPath)
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
		
		let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: indexPath)
		
		if editingStyle == .delete {
			countries.remove(at: [indexPath.section][indexPath.row])
			
			CoreDataAssistant.context.delete(selectedCountry)
		}
		do {
			try CoreDataAssistant.context.save()
		} catch {
			print("PANIC: UITable DeleteRow :: context.save() Failed: \(error)")
		}
		let grandpa = self.parent?.parent as? tabBarController
		grandpa?.tabBar.items?.first?.badgeValue = String((CoreDataAssistant.fetchedResultsController.sections?[0].numberOfObjects)! +
														  (CoreDataAssistant.fetchedResultsController.sections?[1].numberOfObjects)!)
		self.collectionView.reloadData()
		//updateMasterTable()
	}
	
	//MARK: Table moveRowAt()
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		
		guard sourceIndexPath.section == destinationIndexPath.section else { return }

		let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: sourceIndexPath)

		CoreDataAssistant.context.delete(selectedCountry)

		let newCountry = Country(context: CoreDataAssistant.context)
		newCountry.name = selectedCountry.name
		newCountry.countryDescription = selectedCountry.countryDescription
		newCountry.gdp = selectedCountry.gdp
		newCountry.euMember = selectedCountry.euMember
		newCountry.longitude = selectedCountry.longitude
		newCountry.latitude = selectedCountry.latitude
		newCountry.flagPath = selectedCountry.flagPath
		
		do {
			try CoreDataAssistant.context.save()
		} catch {
			print("PANIC: tableView moveRowAt Failed to save(): \(error)")
		}
		self.table.reloadData() //?
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return CoreDataAssistant.fetchedResultsController.sections?[section].numberOfObjects ?? 0
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return CoreDataAssistant.fetchedResultsController.sections?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if let sectionInfo = CoreDataAssistant.fetchedResultsController.sections?[section] {
			if sectionInfo.name == "0" {
				return "Non EU Countries"
			} else {
				return "EU Countries"
			}
		}
		return nil
	}
}

//MARK:  Collection Extensions
extension TableAndCollectionViewController: UICollectionViewDelegate {
	
	
	//MARK: Collection didSelectItemAt()
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath)
		let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: indexPath)
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
		
		return CoreDataAssistant.fetchedResultsController.sections?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return CoreDataAssistant.fetchedResultsController.sections?[section].numberOfObjects ?? 0
	}
	
	
	//MARK: Collection CellForItemAt
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let selectedCountry = CoreDataAssistant.fetchedResultsController.object(at: indexPath)
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell
		
		cell.configure(with: selectedCountry)
		return cell
	}
	
}

//MARK: NSFetchedResultsController

extension TableAndCollectionViewController: NSFetchedResultsControllerDelegate {

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
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

		self.table.reloadData()
	}

}
