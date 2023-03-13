//
//  Core Data Init.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 26.02.23.
//

import Foundation
import CoreData
import UIKit


func initCoreData(context: NSManagedObjectContext) {
	
	let fileManager = FileManager()
	var imagesData = [String : Data]()
	let descriptions = CountryDescriptions()
	
	// The list of image names in the Assets catalog
	let imageNames = ["Flag_of_Greece", "Flag_of_Spain", "Flag_of_Italy", "Flag_of_Portugal", "Flag_of_France", "Flag_of_Luxembourg", "Flag_of_Austria", "Flag_of_Belgium", "Flag_of_Bulgaria", "Flag_of_Croatia", "Flag_of_Cyprus", "Flag_of_Denmark", "Flag_of_Estonia", "Flag_of_Finland", "Flag_of_Malta", "Flag_of_Poland","Flag_of_Romania", "Flag_of_Slovenia", "Flag_of_Sweden", "Flag_of_the_Czech_Republic", "Flag_of_the_Netherlands", "Flag_of_Germany", "Flag_of_Hungary", "Flag_of_Ireland", "Flag_of_Latvia", "Flag_of_Lithuania", "Flag_of_Argentina", "Flag_of_Bolivia", "Flag_of_Brazil", "Flag_of_Chile", "Flag_of_Colombia", "Flag_of_Costa_Rica", "Flag_of_Equador", "Flag_of_Haiti", "Flag_of_Mexico", "Flag_of_Lithuania"]

	// Create  each image and assign to imageData Dictionary
	for imageName in imageNames {
		guard let image = UIImage(named: imageName),
			  let imageData = image.compress(quality: 0.8)
			  else {
			print("PANIC: initCoreData :: forLoop :: failed to compress or get image for '\(imageName)'")
			return
		}
		imagesData[imageName] = imageData
	}
	let defaultNilData = Data()
	
	let countries = [

		["name": "Greece", "countryDescription": descriptions.greece, "flagData": imagesData["Flag_of_Greece" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["greece"]!.latitude, "longitude": locations["greece"]!.longitude ],
		
		["name": "Spain", "countryDescription": "description of Spain", "flagData": imagesData["Flag_of_Spain" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["spain"]!.latitude, "longitude": locations["spain"]!.longitude ],
		
		["name": "Italy", "countryDescription": descriptions.italy, "flagData": imagesData["Flag_of_Italy" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["italy"]!.latitude, "longitude": locations["italy"]!.longitude ],
		
		["name": "Portugal", "countryDescription": "description of portugal", "flagData": imagesData["Flag_of_Portugal" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["portugal"]!.latitude, "longitude": locations["portugal"]!.longitude ],
		
		["name": "France", "countryDescription": descriptions.france, "flagData": imagesData["Flag_of_France" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["france"]!.latitude, "longitude": locations["france"]!.longitude ],
		
		["name": "Luxemburg", "countryDescription": "description of luxembourg", "flagData": imagesData["Flag_of_Luxembourg" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["luxemburg"]!.latitude, "longitude": locations["luxemburg"]!.longitude ],
		
		["name": "Austria", "countryDescription": descriptions.austria, "flagData": imagesData["Flag_of_Austria" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["austria"]!.latitude, "longitude": locations["austria"]!.longitude ],
		
		["name": "Belgium", "countryDescription": descriptions.belgium, "flagData": imagesData["Flag_of_Belgium" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["belgium"]!.latitude, "longitude": locations["belgium"]!.longitude ],
		
		["name": "Bulgaria", "countryDescription": descriptions.bulgaria, "flagData": imagesData["Flag_of_Bulgaria" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["bulgaria"]!.latitude, "longitude": locations["bulgaria"]!.longitude ],
		
		["name": "Croatia", "countryDescription": "description of croatia", "flagData": imagesData["Flag_of_Croatia" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["croatia"]!.latitude, "longitude": locations["croatia"]!.longitude ],
		
		["name": "Cyprus", "countryDescription": descriptions.cyprus, "flagData": imagesData["Flag_of_Cyprus" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["cyprus"]!.latitude, "longitude": locations["cyprus"]!.longitude ],
		
		["name": "Denmark", "countryDescription": descriptions.denmark, "flagData": imagesData["Flag_of_Denmark" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["denmark"]!.latitude, "longitude": locations["denmark"]!.longitude ],
		
		["name": "Estonia", "countryDescription": descriptions.estonia, "flagData": imagesData["Flag_of_Estonia"] ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["estonia"]!.latitude, "longitude": locations["estonia"]!.longitude ],
		
		["name": "Finland", "countryDescription": descriptions.finland, "flagData": imagesData["Flag_of_Finland" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["finland"]!.latitude, "longitude": locations["finland"]!.longitude ],
		
		["name": "Malta", "countryDescription": "description of malta", "flagData": imagesData["Flag_of_Malta" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["malta"]!.latitude, "longitude": locations["malta"]!.longitude ],
		
		["name": "Poland", "countryDescription": "description of poland", "flagData": imagesData["Flag_of_Poland" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["poland"]!.latitude, "longitude": locations["poland"]!.longitude ],
		
		["name": "Romania", "countryDescription": "description of romania", "flagData": imagesData["Flag_of_Romania" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["romania"]!.latitude, "longitude": locations["romania"]!.longitude ],
		
		["name": "Slovenia", "countryDescription": "description of slovenia", "flagData": imagesData["Flag_of_Slovenia" ?? defaultNilData], "euMember": true, "gdp": 12_000_000,
		 "latitude": locations["slovenia"]!.latitude, "longitude": locations["slovenia"]!.longitude ],
		
		["name": "Sweden", "countryDescription": "description of sweden", "flagData": imagesData["Flag_of_Sweden" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["sweden"]!.latitude, "longitude": locations["sweden"]!.longitude ],
		
		["name": "Czech Republic", "countryDescription": "description of poland", "flagData": imagesData["Flag_of_the_Czech_Republic" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["czech"]!.latitude, "longitude": locations["czech"]!.longitude ],
		
		["name": "Netherlands", "countryDescription": "description of netherlands", "flagData": imagesData["Flag_of_the_Netherlands" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["netherlands"]!.latitude, "longitude": locations["netherlands"]!.longitude ],
		
		["name": "Germany", "countryDescription": descriptions.germany, "flagData": imagesData["Flag_of_Germany" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["germany"]!.latitude, "longitude": locations["germany"]!.longitude ],
		
		["name": "Hungary", "countryDescription": descriptions.hungary, "flagData": imagesData["Flag_of_Hungary" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["hungary"]!.latitude, "longitude": locations["hungary"]!.longitude],
		
		["name": "Ireland", "countryDescription": descriptions.ireland, "flagData": imagesData["Flag_of_Ireland" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["ireland"]!.latitude, "longitude": locations["ireland"]!.longitude ],
		
		["name": "Latvia", "countryDescription": "description of latvia", "flagData": imagesData["Flag_of_Latvia" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["latvia"]!.latitude, "longitude": locations["latvia"]!.longitude ],
		
		["name": "Lithuania", "countryDescription": "description of lithuania", "flagData": imagesData["Flag_of_Lithuania" ?? defaultNilData], "euMember": true, "gdp": 12_000_000, "latitude": locations["lithuania"]!.latitude, "longitude": locations["lithuania"]!.longitude ],
		
		["name": "Brazil", "countryDescription": "description of Brazil", "flagData": imagesData["Flag_of_Brazil" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["brazil"]!.latitude, "longitude": locations["brazil"]!.longitude ],
		
		["name": "Bolivia", "countryDescription": "description of Bolivia", "flagData": imagesData["Flag_of_Bolivia" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["bolivia"]!.latitude, "longitude": locations["bolivia"]!.longitude ],
		
		["name": "Chile", "countryDescription": "description of Chile", "flagData": imagesData["Flag_of_Chile" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["chile"]!.latitude, "longitude": locations["chile"]!.longitude ],
		
		["name": "Colombia", "countryDescription": "description of Colombia", "flagData": imagesData["Flag_of_Colombia" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["colombia"]!.latitude, "longitude": locations["colombia"]!.longitude ],
		
		["name": "Costa Rica", "countryDescription": "Costa_Rica!", "flagData": imagesData["Flag_of_Costa_Rica" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["costaRica"]!.latitude, "longitude": locations["costaRica"]!.longitude ],
		
		["name": "Equador", "countryDescription": "description of Equador", "flagData": imagesData["Flag_of_Equador" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["equador"]!.latitude, "longitude": locations["equador"]!.longitude ],
		
		["name": "Haiti", "countryDescription": "description of Haiti", "flagData": imagesData["Flag_of_Haiti" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["haiti"]!.latitude, "longitude": locations["haiti"]!.longitude ],
		
		["name": "Mexico", "countryDescription": "description of Mexico!", "flagData": imagesData["Flag_of_Mexico" ?? defaultNilData], "euMember": false, "gdp": 12_000_000, "latitude": locations["mexico"]!.latitude, "longitude": locations["mexico"]!.longitude]
	]
	
	let batchInsert = NSBatchInsertRequest(entity: Country.entity(), objects: countries)
	
	do {
		try context.execute(batchInsert)
	} catch {
		print("PANIC: initCoreData :: try context.execute(batchInsert)")
		return
	}
	do {
		try context.save()
	}
	catch {
		print("context.save() from initCoreData() failed")
	}
	UserDefaults.standard.set(true, forKey: "CountriesAreInitialised")
}
