//
//  CoreData.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.03.23.
//

import Foundation
import UIKit
import CoreData

final class CoreDataAssistant {
	
	static var intermediateCountries = {
		return loadCountries()
		
	}()
	
//	private init() { }
	
	static var context: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()
	
	static var persistentContainer: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "TableViewController")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("PANIC: Unresolved error from AppDelegate :: persistentContainer -> \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	static var fetchedResultsController: NSFetchedResultsController<Country> = {
		let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(key: "euMember", ascending: false),
			NSSortDescriptor(key: "name", ascending: true)
		]
		
		// Use a custom keyPath to group the countries into two sections based on euMember attribute
		let sectionKeyPath = #keyPath(Country.euMember)
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
													managedObjectContext: context,
													sectionNameKeyPath: sectionKeyPath,
													cacheName: nil)
		do {
			try controller.performFetch()
		} catch {
			print("PANIC: Fetch Request Failed: \(error)")
		}
		return controller
	}()
	
	static func saveContext() {
		
		if self.context.hasChanges {
			do {
				try CoreDataAssistant.context.save()
			} catch {
				print("PANIC: Unresolved error from saveContext(): \(error)")
			}
		}
	}
	
	static func loadCountries() -> [[Country]] {
		
		var countries = [[Country]]()
		print("loadCountries() CALLED:")
		if let sections = CoreDataAssistant.fetchedResultsController.sections {
			for section in sections {
				var countriesInSection : [Country] = []
				if let objects = section.objects as? [Country] {
					for object in objects {
						print(object.name!)
						countriesInSection.append(object)
					}
				}
				countries.append(countriesInSection)
			}
		}
		return countries
	}
	
	//MARK: sortCountries()
//	static func sortCountries(for section: Int) -> [[Country]] {
//		
//		if section == 0 {
//			
//			let newSortedEuCountries = self.intermediateCountries[0].sorted { $0.name < $1.name }
//			return [newSortedEuCountries, self.intermediateCountries[1]]
//		} else if section == 1 {
//			
//			let newSortedNonEuCountries = self.intermediateCountries[1].sorted { $0."name" < $1."name" }
//			return [self.intermediateCountries[0], newSortedNonEuCountries]
//		} else {
//			print("ERORR: sortCountries(section: Int) returned ' [[]] '")
//			return [[]] }
//	}
}
