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
	var flagPaths: [String: URL] = [:]
	
	private init() {
		createFlagsDirectory()
	}
	
	private func createFlagsDirectory() {
		guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			print("PANIC:  FileAssistant :: createFlagsDirectory() :: documentDirectory")
			return
		}
		let flagsDirectory = documentDirectory.appendingPathComponent("Flags", isDirectory: true)
		self.flagsDirectory = flagsDirectory
		
		do {
			if !fileManager.fileExists(atPath: flagsDirectory.path) {
				try fileManager.createDirectory(at: flagsDirectory, withIntermediateDirectories: true, attributes: nil)
			}
			
			// Create flagPaths.plist file
			let flagPathsFile = flagsDirectory.appendingPathComponent("flagPaths.plist", isDirectory: false)
			if !fileManager.fileExists(atPath: flagPathsFile.path) {
				let initialData = NSDictionary() // Empty dictionary
				let success = initialData.write(to: flagPathsFile, atomically: true)
				if !success {
					print("Failed to create flagPaths.plist file.")
				}
			}
		} catch {
			print("PANIC: FileAssistant :: createFlagsDirectory() while creating 'flagsDirectory' directory")
		}
	}
	
	func loadFlagPaths() {
		let check = self.flagPaths
		// self.flagPaths is nil !!
		guard let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist", isDirectory: false),
			  let savedFlagPaths = NSDictionary(contentsOf: flagPathsFile) as? [String: String] else {
			print("File Assistant :: loadFlagPaths() :: guard let")
			return
		}
		for (country, path) in savedFlagPaths {
			let flagPath = flagsDirectory?.appendingPathComponent(path, isDirectory: false)
			if fileManager.fileExists(atPath: flagPath!.path) {
				self.flagPaths[country] = flagPath
				print("Loaded flag path for \(country): \(flagPath!)")
			} else {
				print("Flag file does not exist for \(country)")
			}
		}
	}


	func saveFlagPath(for country: String, imagePath: URL) {
		self.flagPaths[country] = imagePath
		let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist")
		
		// Convert [String: URL] dictionary to [String: String] dictionary
		let stringPaths = flagPaths.reduce(into: [String: String]()) { dict, tuple in
			dict[tuple.key] = tuple.value.relativePath
		}
		
		// Write dictionary to plist file
		let plistData = stringPaths as NSDictionary
		let success = plistData.write(to: flagPathsFile!, atomically: true)
		if !success {
			print("Failed to save flagPath to plist file.")
		}
		print("\(flagPaths)")
	}

}



///Singeton of CoreData for NSFetchedResultController .
final class CoreDataAssistant {
	
	private init() { }
	
	static var userDefaults = UserDefaults()
	
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
				let nserror = error as NSError
				fatalError("PANIC: Unresolved error from saveContext(): \(nserror), \(nserror.userInfo)")
			}
		}
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
