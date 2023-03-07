//
//  Disk Ops.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.02.23.
//

import Foundation
import UIKit
import CoreData

/// Singleton of FileManager.default for  Flags Directory Operations
class FileAssistant {
	
	static let shared = FileAssistant()
	
	let fileManager = FileManager.default
	var flagsDirectory: URL?
	var flagPaths: [String: String] = [:]
	
	private init() {
		
		createFlagsDirectory()
		loadFlagPaths()
	}
	
	private func createFlagsDirectory() {

		guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			print("PANIC:  FileAssistant :: createFlagsDirectory() :: while getting documentDirectory")
			return
		}
		let flagsDirectory = documentDirectory.appendingPathComponent("Flags", isDirectory: true)
		self.flagsDirectory = flagsDirectory
		
		do {
			if !fileManager.fileExists(atPath: flagsDirectory.path()) {
				try fileManager.createDirectory(at: flagsDirectory, withIntermediateDirectories: true, attributes: nil)
			}
		} catch {
			print("PANIC: FileAssistant :: createFlagsDirectory() while creating 'flagsDirectory' directory")
		}
	}
	
	private func loadFlagPaths() {

		//MARK: CHECK fileExists(atPath:isDirectory:)
		let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist")
		if let flagPaths = NSDictionary(contentsOf: flagPathsFile!) as? [String: String] {
			self.flagPaths = flagPaths
		}
	}
	
	func saveFlagPath(for country: String, imagePath: String) {
		
		flagPaths[country] = imagePath
//		for flag in flagPaths {
//			print(flag)
//		}
		let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist")
		let plistData = flagPaths as NSDictionary
		plistData.write(to: flagPathsFile!, atomically: true)
	}
	
}

///Singeton of CoreData for NSFetchedResultController .
final class CoreDataAssistant {
	
	private init() { }
	
	//	static let shared = CoreDataAssistant()
	
	//lazy var context = CoreDataAssistant.persistentContainer.viewContext
	
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
	
	static func saveContext() {
		
		if CoreDataAssistant.context.hasChanges {
			do {
				try CoreDataAssistant.context.save()
			} catch {
				let nserror = error as NSError
				fatalError("PANIC: Unresolved error from saveContext(): \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	static func fetch() -> [[Country]] {
		
		let fetchRequest = Country.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
		let fetchedObjects = try? CoreDataAssistant.context.fetch(fetchRequest)
		
		guard let countries = fetchedObjects else {
			return [[Country]]()
		}
		
		let euCountries = countries.filter { $0.euMember == true }.sorted { $0.name < $1.name }
		let nonEuCountries = countries.filter { $0.euMember == false }.sorted { $0.name < $1.name }
		
		return [euCountries, nonEuCountries]
	}
}
	
	// Should be here? Check the NameKeyPath??
//	lazy var fetchedResultsController: NSFetchedResultsController<Country> = {
//
//		let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
//		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//		let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
//													managedObjectContext: context,
//													sectionNameKeyPath: "isEu = YES", cacheName: nil)
//		return controller
//	}()
	
	
	//	func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
	//
	//		let entityName = String(describing: objectType)
	//		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
	//
	//		do {
	//			let fetchedObjects = try context.fetch(fetchRequest) as? [T]
	//			return fetchedObjects ?? [T]()
	//
	//		} catch {
	//			print("PANIC: fetch<T: NSManagedObject> -> \(error)")
	//			return [T]()
	//		}
	//	}
	//}
	//
	//
	//func getCountries(context: NSManagedObjectContext) -> [Country] {
	//
	//	let countries = CoreDataAssistant.shared.fetch(Country.self)
	//
	//	return countries
	//}
	

