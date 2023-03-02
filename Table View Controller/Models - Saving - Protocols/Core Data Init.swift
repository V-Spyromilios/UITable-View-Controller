//
//  Core Data Init.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 26.02.23.
//

import Foundation
import CoreData
import UIKit

// OR somehow assign directly to degeue reusable cell
var euCountries : [EuCountries] = []
var otherCountries : [OtherCountries] = []


func initCoreData(context: NSManagedObjectContext) {

	let flagsDirectory = FileAssistant.shared.flagsDirectory
	let flagPaths = FileAssistant.shared.flagPaths
	let assistant = FileAssistant.shared
	
	// Get the list of image names in the Assets catalog
	let imageNames = ["Flag_of_Greece", "Flag_of_Spain", "Flag_of_Italy", "Flag_of_Portugal", "Flag_of_France", "Flag_of_Luxembourg", "Flag_of_Austria", "Flag_of_Belgium", "Flag_of_Bulgaria", "Flag_of_Croatia", "Flag_of_Cyprus", "Flag_of_Denmark", "Flag_of_Estonia", "Flag_of_Finland", "Flag_of_Malta", "Flag_of_Poland"," Flag_of_Romania", "Flag_of_Slovenia", "Flag_of_Sweden", "Flag_of_the_Czech_Republic", "Flag_of_the_Netherlands", "Flag_of_Germany", "Flag_of_Hungary", "Flag_of_Ireland", "Flag_of_Latvia", "Flag_of_Lithuania", "Flag_of_Argentina", "Flag_of_Bolivia", "Flag_of_Brazil", "Flag_of_Chile", "Flag_of_Colombia", "Flag_of_Costa_Rica", "Flag_of_Equador", "Flag_of_Haiti", "Flag_of_Mexico", "Flag_of_Lithuania"]
	

	for imageName in imageNames {

		guard let image = UIImage(named: imageName) else {
			print("PANIC: initCoreData() :: failed to create UIImage from String '\(imageName)'")
			continue
		}
		let imagePath = assistant.flagsDirectory?.appendingPathComponent("\(imageName).png")
		guard let imageData = image.pngData() else {
			print("PANIC: initCoreData() :: failed to Convert image '\(imageName)'to .png")
			continue
		}
		if let ipath = imagePath {
			FileManager.default.createFile(atPath: ipath.path(), contents: imageData)
			assistant.saveFlagPath(for: imageName, imagePath: ipath.path())
		} else { print("PANIC: initCoreData() :: Check ipath, failed to Unwrap Optional") }
	}

	let euCountries = [
		
		["name": "Greece", "countryDescription": descriptions.greece, "flagPath": flagPaths["Flag_of_Greece"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["greece"]!.latitude, "longitude": locations["greece"]!.longitude ],
		
		["name": "Spain", "countryDescription": "description of Spain", "flagPath": flagPaths["Flag_of_Spain"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["spain"]!.latitude, "longitude": locations["spain"]!.longitude ],
		
		["name": "Italy", "countryDescription": descriptions.italy, "flagPath": flagPaths["Flag_of_Italy"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["italy"]!.latitude, "longitude": locations["italy"]!.longitude ],
		
		["name": "Portugal", "countryDescription": "description of portugal", "flagPath": flagPaths["Flag_of_Portugal"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["portugal"]!.latitude, "longitude": locations["portugal"]!.longitude ],
		
		["name": "France", "countryDescription": descriptions.france, "flagPath": flagPaths["Flag_of_France"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["france"]!.latitude, "longitude": locations["france"]!.longitude ],
		
		["name": "Luxemburg", "countryDescription": "description of luxembourg", "flagPath": flagPaths["Flag_of_Luxembourg"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["luxemburg"]!.latitude, "longitude": locations["luxemburg"]!.longitude ],
		
		["name": "Austria", "countryDescription": descriptions.austria, "flagPath": flagPaths["Flag_of_Austria"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["austria"]!.latitude, "longitude": locations["austria"]!.longitude ],
		
		["name": "Belgium", "countryDescription": descriptions.belgium, "flagPath": flagPaths["Flag_of_Belgium"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["belgium"]!.latitude, "longitude": locations["Belgium"]!.longitude ],
		
		["name": "Bulgaria", "countryDescription": descriptions.bulgaria, "flagPath": flagPaths["Flag_of_Bulgaria"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["bulgaria"]!.latitude, "longitude": locations["bulgaria"]!.longitude ],
		
		["name": "Croatia", "countryDescription": "description of croatia", "flagPath": flagPaths["Flag_of_Croatia"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["croatia"]!.latitude, "longitude": locations["croatia"]!.longitude ],
		
		["name": "Cyprus", "countryDescription": descriptions.cyprus, "flagPath": flagPaths["Flag_of_Cyprus"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["cyprus"]!.latitude, "longitude": locations["cyprus"]!.longitude ],
		
		["name": "Denmark", "countryDescription": descriptions.denmark, "flagPath": flagPaths["Flag_of_Denmark"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["denmark"]!.latitude, "longitude": locations["denmark"]!.longitude ],
		
		["name": "Estonia", "countryDescription": descriptions.estonia, "flagPath": flagPaths["Flag_of_Estonia"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["estonia"]!.latitude, "longitude": locations["estonia"]!.longitude ],
		
		["name": "Finland", "countryDescription": descriptions.finland, "flagPath": flagPaths["Flag_of_Finland"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["finland"]!.latitude, "longitude": locations["finland"]!.longitude ],
		
		["name": "Malta", "countryDescription": "description of malta", "flagPath": flagPaths["Flag_of_Malta"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["malta"]!.latitude, "longitude": locations["malta"]!.longitude ],
		
		["name": "Poland", "countryDescription": "description of poland", "flagPath": flagPaths["Flag_of_Poland"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["poland"]!.latitude, "longitude": locations["poland"]!.longitude ],
		
		["name": "Romania", "countryDescription": "description of romania", "flagPath": flagPaths["Flag_of_Romania"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["romania"]!.latitude, "longitude": locations["romania"]!.longitude ],
		
		["name": "Slovenia", "countryDescription": "description of slovenia", "flagPath": flagPaths["Flag_of_Slovenia"]! , "euMember": true, "gdp": 12_000_000,
		 "latitude": locations["slovenia"]!.latitude, "longitude": locations["slovenia"]!.longitude ],
		
		["name": "Sweden", "countryDescription": "description of sweden", "flagPath": flagPaths["Flag_of_Sweden"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["sweden"]!.latitude, "longitude": locations["sweden"]!.longitude ],
		
		["name": "Czech Republic", "countryDescription": "description of poland", "flagPath": flagPaths["Flag_of_the_Czech_Republic"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["czech"]!.latitude, "longitude": locations["czech"]!.longitude ],
		
		["name": "Netherlands", "countryDescription": "description of netherlands", "flagPath": flagPaths["Flag_of_the_Netherlands"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["netherlands"]!.latitude, "longitude": locations["netherlands"]!.longitude ],
		
		["name": "Germany", "countryDescription": descriptions.germany, "flagPath": flagPaths["Flag_of_Germany"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["germany"]!.latitude, "longitude": locations["germany"]!.longitude ],
		
		["name": "Hungary", "countryDescription": descriptions.hungary, "flagPath": flagPaths["Flag_of_Hungary"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["hungary"]!.latitude, "longitude": locations["hungary"]!.longitude],
		
		["name": "Ireland", "countryDescription": descriptions.ireland, "flagPath": flagPaths["Flag_of_Ireland"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["ireland"]!.latitude, "longitude": locations["ireland"]!.longitude ],
		
		["name": "Latvia", "countryDescription": "description of latvia", "flagPath": flagPaths["Flag_of_Latvia"]! , "euMember": true, "gdp": 12_000_000, "latitude": locations["latvia"]!.latitude, "longitude": locations["latvia"]!.longitude ],
		
		["name": "Lithuania", "countryDescription": "description of lithuania", "flagPath": flagPaths["Flag_of_Lithuania"]!, "euMember": true, "gdp": 12_000_000, "latitude": locations["lithuania"]!.latitude, "longitude": locations["lithuania"]!.longitude ]
	]

	let otherCountries = [
	
		["name": "Brazil", "countryDescription": "description of Brazil", "flagPath": flagPaths["Flag_of_Brazil"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["brazil"]!.latitude, "longitude": locations["brazil"]!.longitude ],
		
		["name": "Bolivia", "countryDescription": "description of Bolivia", "flagPath": flagPaths["Flag_of_Bolivia"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["bolivia"]!.latitude, "longitude": locations["bolivia"]!.longitude ],
		
		["name": "Chile", "countryDescription": "description of Chile", "flagPath": flagPaths["Flag_of_Chile"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["chile"]!.latitude, "longitude": locations["chile"]!.longitude ],
		
		["name": "Colombia", "countryDescription": "description of Colombia", "flagPath": flagPaths["Flag_of_Colombia"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["colombia"]!.latitude, "longitude": locations["colombia"]!.longitude ],
		
		["name": "Costa Rica", "countryDescription": "Costa_Rica!", "flagPath": flagPaths["Flag_Of_Costa_Rica"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["costaRica"]!.latitude, "longitude": locations["costaRica"]!.longitude ],
		
		["name": "Equador", "countryDescription": "description of Equador", "flagPath": flagPaths["Flag_of_Equador"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["equador"]!.latitude, "longitude": locations["equador"]!.longitude ],
		
		["name": "Haiti", "countryDescription": "description of Haiti", "flagPath": flagPaths["Flag_of_Haiti"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["haiti"]!.latitude, "longitude": locations["haiti"]!.longitude ],
		
		["name": "Mexico", "countryDescription": "description of Mexico!", "flagPath": flagPaths["Flag_of_Mexico"]! , "euMember": false, "gdp": 12_000_000, "latitude": locations["mexico"]!.latitude, "longitude": locations["mexico"]!.longitude]
	]
	
	let batchInsert = NSBatchInsertRequest(entity: EuCountries.entity(), objects: euCountries)
	let batchInsert2 = NSBatchInsertRequest(entity: OtherCountries.entity(), objects: otherCountries)
	do {
		try context.execute(batchInsert)
		try context.execute(batchInsert2)
	} catch {
		print("PANIC: initCoreData :: context.execute batch")
	}
}

func loadData(context: NSManagedObjectContext) {
	do {
		let request = EuCountries.fetchRequest()
		let sort = NSSortDescriptor(key: "name", ascending: true)
		request.sortDescriptors = [sort]
		euCountries = try context.fetch(request)
	} catch {
		print("PANIC: loadData(context) :: EuCountries")
	}

	do {
		let request = OtherCountries.fetchRequest()
		let sort = NSSortDescriptor(key: "name", ascending: true)
		request.sortDescriptors = [sort]
		otherCountries = try context.fetch(request)
	} catch {
		print("PANIC: loadData(context) :: OtherCountries")
	}
}
