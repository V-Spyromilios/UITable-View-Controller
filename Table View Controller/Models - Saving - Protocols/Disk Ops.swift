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
	var plistUrl : URL?
	var flagPaths: [String: URL] = [:]
	
	

	/// Creates empty 'flagPaths.plist' inside  ../documents/Flags/
	/// sets the self.flagsDirectory
	func createFlagsDirectories() {

		// find and return the documents directory as URL
		guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.absoluteURL else {
			print("PANIC: FileAssistant :: createFlagsDirectory() :: documentDirectory")
			return
		}

		//create the URL of ../documents/Flags, save to FileAssistant & to userDefaults
		let flagsDirectory = documentDirectory.appendingPathComponent("Flags", isDirectory: true).absoluteURL
		self.flagsDirectory = flagsDirectory
		UserDefaults.standard.set(flagsDirectory, forKey: "storedFlagsDirectory")
		
		
		if let flagsDirectoryUrl = self.flagsDirectory {
				do {
					// create the actual folder 'Flags' from the URL
					try fileManager.createDirectory(at: flagsDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
					print("Disk Ops :: createDirectory :: 'Flag Images' at: \(flagsDirectoryUrl.path())")
				} catch {
					print("PANIC: FileAssistant :: createFlagsDirectory() while creating 'flagsDirectoryUrl' directory")
				}
				// create the URL for the plist, save to FileAssistant & to userDefaults
			let plistUrl = flagsDirectoryUrl.appendingPathComponent("flagPaths.plist", isDirectory: false).absoluteURL
				self.plistUrl = plistUrl
			UserDefaults.standard.set(plistUrl, forKey: "plistUrl")

				//Write  the actual Dictionary to plistURL
				if !fileManager.fileExists(atPath: plistUrl.path) {
					let nsDictionary = NSDictionary()
					// write an empty dictionary to the 'flagPathsPlistUrl' 'URL
					let success = nsDictionary.write(to: plistUrl, atomically: true)
					print("flagPathsPlistUrl: \(plistUrl)")
					if !success {
						print("Failed to create 'flagPaths.plist' file.")
					}
				}
			
		} else { print("createFlagsDirectory() :: flagsDirectoryUrl is nil!") }
	}


	
	func loadFlagPaths() {
		
		// create the url to the .plist  (../documents/flagPaths.plist - load the plist as NSDictionary and downcast it to [String : String]
		// use it for subsequent runs ! so load the dir, self.flagsDirectory? is nil in subsequent runs TRY userDefaults to save the flagsDirectory in order to build after this. First save it at the end of initCoreData!
		//		if let savedFlagsDirectoryString = FileAssistant.shared.userDefaults.string(forKey: "storedFlagsDirectory") {
		//			print("savedFlagsDirectoryString: \(savedFlagsDirectoryString)")
		//			if let savedFlagsDirectory = URL(string: savedFlagsDirectoryString) {
		//				print(savedFlagsDirectory)
		
		//				self.flagsDirectory = savedFlagsDirectory
		guard let flagsDirectoryUrl = UserDefaults.standard.url(forKey: "storedFlagsDirectory")?.absoluteURL else {
			print("laodFlagPaths :: userDefaults:forKey 'storedFlagsDirectory' is nil!")
			return
		}
		
		guard let savedDictionaryUrl = UserDefaults.standard.url(forKey: "plistUrl")?.absoluteURL else {
			print("loadFlagPaths :: plistUlrl is nil.")
			return
		}
		
		guard let savedDictionary = NSDictionary(contentsOf: savedDictionaryUrl) as? [String: String] else {
			print("PANIC: File Assistant :: loadFlagPaths() :: guard 'savedFlagDictionary' failed.")
			return
		}
		
		self.flagsDirectory = flagsDirectoryUrl
		self.plistUrl = savedDictionaryUrl

		for (country, path) in savedDictionary {
			let flagPath = flagsDirectoryUrl.appendingPathComponent(path, isDirectory: false).absoluteURL
			if fileManager.fileExists(atPath: flagPath.path) {
				self.flagPaths[country] = flagPath
				print("Loaded flag path for: \(country)")
			} else {
				print("loadFlagPaths :: !fileManager.fileExists")
				return
			}
		}
	}

	func savePathsDictionary(dictionary: [String: URL]) {

		guard let plistUrl = self.plistUrl else {
			print("saveFlagPaths :: self.plistUrl is nil.")
			return
		}

		// Convert [String: URL] dictionary to [String: String] dictionary
		let dictionaryWithStrings = dictionary.reduce(into: [String: String]()) { dict, tuple in
			dict[tuple.key] = tuple.value.absoluteString
		}

		// Write dictionary to plist file
		let nsDictionary = NSDictionary(dictionary: dictionaryWithStrings)
		let success = nsDictionary.write(to: plistUrl, atomically: true)
//		self.flagPaths = dictionary // initCoreData writes this
		if !success {
			print("Failed to save flagpaths to plist file.")
		}
		print("flagPaths from saveFlagPaths(): \(flagPaths)")
	}
}




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
