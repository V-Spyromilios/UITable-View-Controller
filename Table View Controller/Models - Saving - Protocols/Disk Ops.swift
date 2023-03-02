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
		
		let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist")
		if let flagPaths = NSDictionary(contentsOf: flagPathsFile!) as? [String: String] {
			self.flagPaths = flagPaths
		}
	}
	
	func saveFlagPath(for country: String, imagePath: String) {
		
		flagPaths[country] = imagePath
		
		let flagPathsFile = flagsDirectory?.appendingPathComponent("flagPaths.plist")
		let plistData = flagPaths as NSDictionary
		plistData.write(to: flagPathsFile!, atomically: true)
	}
	
}

///Singeton of CoreData for NSFetchedResultController .
class CoreDataAssistant {
	
	static let shared = CoreDataAssistant()
	
	var fetchedResultsController : NSFetchedResultsController<Country>?
	
	lazy var context : NSManagedObjectContext = {
		return ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
	}()
	
	var euFetchedResultsController: NSFetchedResultsController<EuCountries>!
	var nonEuFetchedResultsController: NSFetchedResultsController<OtherCountries>!
	
	private init() {
		// Set up the fetched results controller for EuCountries
		let euRequest: NSFetchRequest<EuCountries> = EuCountries.fetchRequest()
		let euSort = NSSortDescriptor(key: "name", ascending: true)
		euRequest.sortDescriptors = [euSort]
		euFetchedResultsController = NSFetchedResultsController(fetchRequest: euRequest,
																managedObjectContext: context,
																sectionNameKeyPath: nil,
																cacheName: nil)

		// Set up the fetched results controller for OtherCountries
		let otherRequest: NSFetchRequest<OtherCountries> = OtherCountries.fetchRequest()
		let otherSort = NSSortDescriptor(key: "name", ascending: true)
		otherRequest.sortDescriptors = [otherSort]
		nonEuFetchedResultsController = NSFetchedResultsController(fetchRequest: otherRequest,
																   managedObjectContext: context,
																   sectionNameKeyPath: nil,
																   cacheName: nil)

		do {
			try euFetchedResultsController.performFetch()
			try nonEuFetchedResultsController.performFetch()
		} catch {
			print("Error fetching data: \(error.localizedDescription)")
		}
	}
}
