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
	
	let descriptions = CountryDescriptions()
	let unionMembers = EuDescriptions()
	
	// The list of image names in the Assets catalog
	let imageNames = ["Flag_of_Greece", "Flag_of_Spain", "Flag_of_Italy", "Flag_of_Portugal", "Flag_of_France", "Flag_of_Luxembourg", "Flag_of_Austria", "Flag_of_Belgium", "Flag_of_Bulgaria", "Flag_of_Croatia", "Flag_of_Cyprus", "Flag_of_Denmark", "Flag_of_Estonia", "Flag_of_Finland", "Flag_of_Malta", "Flag_of_Poland","Flag_of_Romania", "Flag_of_Slovenia", "Flag_of_Sweden", "Flag_of_the_Czech_Republic", "Flag_of_the_Netherlands", "Flag_of_Germany", "Flag_of_Hungary", "Flag_of_Ireland", "Flag_of_Latvia", "Flag_of_Lithuania", "Flag_of_Argentina", "Flag_of_Bolivia", "Flag_of_Brazil", "Flag_of_Chile", "Flag_of_Colombia", "Flag_of_Costa_Rica", "Flag_of_Equador", "Flag_of_Haiti", "Flag_of_Mexico"]
	
	
	for imageName in imageNames {
		let test = Country(context: CoreDataAssistant.context)
		
		guard let image = UIImage(named: imageName),
			  let imageData = image.compress(quality: 0.7)
		else {
			print("PANIC: initCoreData :: forLoop :: failed to compress or get image for '\(imageName)'")
			return
		}
		test.flagData = imageData
		
		var clearedName = imageName.components(separatedBy: "Flag_of_").last?.replacingOccurrences(of: "_", with: " ")
		clearedName = clearedName?.replacingOccurrences(of: "the ", with: "")
		if let clearedName = clearedName {
			test.name = clearedName
			
			let lowercasedName = clearedName.lowercased()
			test.countryDescription = descriptions.getCountryDescription(for: clearedName)
			test.euMember = unionMembers.getEuStatus(for: lowercasedName)
			test.latitude = locations[lowercasedName]?.latitude ?? 0.0
			test.longitude = locations[lowercasedName]?.longitude ?? 0.0
			test.gdp = 7000000
		}
	}
	do {
		try context.save()
	}
	catch {
		print("PANIC: context.save() from initCoreData() failed")
	}
	UserDefaults.standard.set(true, forKey: "CountriesAreInitialised")
}
