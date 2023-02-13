//
//  Disk Ops.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.02.23.
//

import Foundation

let countriesFileURL = getDocumentsDirectory().appending(path: "sortedCountries.json")

let locationsFileURL = getDocumentsDirectory().appending(path: "locations.json")

func getDocumentsDirectory() -> URL {
	
	let fileManager = FileManager.default
	let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
	return urls[0]
}

func loadDatafromJson() {
	
	let decoder = JSONDecoder()
	
	if let locationsJsonData = try? Data(contentsOf: locationsFileURL) {
		
		do { locations = try decoder.decode([String:Location].self, from: locationsJsonData)
		} catch { print("ERROR: locationsJsonData -> \(error)") }
	}
	
	if let sortedCountriesJsonData = try? Data(contentsOf: countriesFileURL) {
		do {
			sortedCountries = try decoder.decode([[CountryModel]]?.self, from: sortedCountriesJsonData)!
		} catch { print("ERROR: sortedCountriesJsonData -> \(error)") }
	}
}

func saveDataToJson() {
	
	let encoder = JSONEncoder()
	
	if let countriesData = try? encoder.encode(sortedCountries) {
		do {
			try countriesData.write(to: countriesFileURL, options: .completeFileProtection)
		} catch { print("ERROR: APP WILL RESIGN countriesData -> \(error)") }
	}
	
	if let locationsData = try? encoder.encode(locations) {
		do {
			try locationsData.write(to: locationsFileURL, options: .completeFileProtection)
		}
		catch { print("ERROR APP WILL RESIGN locationsData -> \(error)") }
	}
}
