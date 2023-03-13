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
	
	private init() { }
	
	
	
	static var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
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
													managedObjectContext: CoreDataAssistant.context,
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
		
		if CoreDataAssistant.context.hasChanges {
			do {
				try CoreDataAssistant.context.save()
			} catch {
				print("PANIC: Unresolved error from saveContext(): \(error)")
			}
		}
	}
}
