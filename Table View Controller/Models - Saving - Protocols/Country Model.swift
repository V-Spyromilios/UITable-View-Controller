//
//  Countries Model.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import Foundation
import UIKit
import MapKit

struct CountryModel {
	
	var name: String = ""
	var description: String = ""
	var flag: UIImage?
	var euMember: Bool
	var gdp: Int?
	var location: Location
}

let descriptions = CountryDescriptions()

var countries : [[CountryModel]] = [ [
	
	CountryModel(name: "Greece", description: descriptions.greece, flag: UIImage(named: "Flag_of_Greece") , euMember: true, gdp: 12_000_000, location: locations["greece"] ?? defaultLocation),
	
	CountryModel(name: "Italy", description: descriptions.italy, flag: UIImage(named: "Flag_of_Italy"), euMember: true, gdp: 12_000_000, location: locations["italy"] ?? defaultLocation),
	
	CountryModel(name: "Austria", description: descriptions.austria, flag: UIImage(named: "Flag_of_Austria"), euMember: true, gdp: 12_000_000, location: locations["austria"] ?? defaultLocation),
	
	CountryModel(name: "Belgium", description: descriptions.belgium, flag: UIImage(named: "Flag_of_Belgium"), euMember: true, gdp: 12_000_000, location: locations["belgium"] ?? defaultLocation),
	
	CountryModel(name: "Bulgaria", description: descriptions.bulgaria, flag: UIImage(named: "Flag_of_Bulgaria"), euMember: true, gdp: 12_000_000, location: locations["bulgaria"] ?? defaultLocation),
	
	CountryModel(name: "Cyprus", description: descriptions.cyprus, flag: UIImage(named: "Flag_of_Cyprus"), euMember: true, gdp: 12_000_000, location: locations["cyprus"] ?? defaultLocation),
	
	CountryModel(name: "Denmark", description: descriptions.denmark, flag: UIImage(named: "Flag_of_Denmark"), euMember: true, gdp: 12_000_000, location: locations["denmark"] ?? defaultLocation),
	
	CountryModel(name: "Estonia", description: descriptions.estonia, flag: UIImage(named: "Flag_of_Estonia"), euMember: true, gdp: 12_000_000, location: locations["estonia"] ?? defaultLocation),
	
	CountryModel(name: "Finland", description: descriptions.finland, flag: UIImage(named: "Flag_of_Finland"), euMember: true, gdp: 12_000_000, location: locations["finland"] ?? defaultLocation),
	
	CountryModel(name: "France", description: descriptions.france, flag: UIImage(named: "Flag_of_France"), euMember: true, gdp: 12_000_000, location: locations["france"] ?? defaultLocation),
	
	CountryModel(name: "Germany", description: descriptions.germany, flag: UIImage(named: "Flag_of_Germany"), euMember: true, gdp: 12_000_000, location: locations["germany"] ?? defaultLocation),
	
	CountryModel(name: "Hungary", description: descriptions.hungary, flag: UIImage(named: "Flag_of_Hungary"), euMember: true, gdp: 12_000_000, location: locations["hungary"] ?? defaultLocation),
	
	CountryModel(name: "Ireland", description: descriptions.ireland, flag: UIImage(named: "Flag_of_Ireland"), euMember: true, gdp: 12_000_000, location: locations["ireland"] ?? defaultLocation),
	
	CountryModel(name: "Latvia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Latvia"), euMember: true, gdp: 12_000_000, location: locations["latvia"] ?? defaultLocation),
	
	CountryModel(name: "Lithuania", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Lithuania"), euMember: true, gdp: 12_000_000, location: locations["lithuania"] ?? defaultLocation),
	
	CountryModel(name: "Luxembourg", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Luxembourg"), euMember: true, gdp: 12_000_000, location: locations["luxemburg"] ?? defaultLocation),
	
	CountryModel(name: "Malta", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Malta"), euMember: true, gdp: 12_000_000, location: locations["malta"] ?? defaultLocation),
	
	CountryModel(name: "Poland", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Poland"), euMember: true, gdp: 12_000_000, location: locations["poland"] ?? defaultLocation),
	
	CountryModel(name: "Portugal", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Portugal"), euMember: true, gdp: 12_000_000, location: locations["portugal"] ?? defaultLocation),
	
	CountryModel(name: "Romania", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Romania"), euMember: true, gdp: 12_000_000, location: locations["romania"] ?? defaultLocation),
	
	CountryModel(name: "Slovakia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Slovakia"), euMember: true, gdp: 12_000_000, location: locations["slovakia"] ?? defaultLocation),
	
	CountryModel(name: "Slovenia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Slovenia"), euMember: true, gdp: 12_000_000, location: locations["slovenia"] ?? defaultLocation),
	
	CountryModel(name: "Spain", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Spain"), euMember: true, gdp: 12_000_000, location: locations["spain"] ?? defaultLocation),
	
	CountryModel(name: "Sweden", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Sweden"), euMember: true, gdp: 12_000_000, location: locations["sweden"] ?? defaultLocation),
	
	CountryModel(name: "Croatia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Croatia"), euMember: true, gdp: 12_000_000, location: locations["croatia"] ?? defaultLocation),
	
	CountryModel(name: "Czech Republic", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_the_Czech_Republic"), euMember: true, gdp: 12_000_000, location: locations["czech"] ?? defaultLocation),
	
	CountryModel(name: "Netherlands", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_the_Netherlands"), euMember: true, gdp: 12_000_000, location: locations["netherlands"] ?? defaultLocation),
],

 [
	CountryModel(name: "Brazil", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Brazil"), euMember: false, gdp: 12_000_000, location: locations["brazil"] ?? defaultLocation),
	
	CountryModel(name: "Chile", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Chile"), euMember: false, gdp: 12_000_000, location: locations["chile"] ?? defaultLocation),
	
	CountryModel(name: "Colombia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Colombia"), euMember: false, gdp: 12_000_000, location: locations["colombia"] ?? defaultLocation),
	
	CountryModel(name: "Costa Rica", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Costa_Rica"), euMember: false, gdp: 12_000_000, location: locations["costaRica"] ?? defaultLocation),
	
	CountryModel(name: "Equador", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Equador"), euMember: false, gdp: 12_000_000, location: locations["equador"] ?? defaultLocation),
	
	CountryModel(name: "Haiti", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Haiti"), euMember: false, gdp: 12_000_000, location: locations["haiti"] ?? defaultLocation),
	
	CountryModel(name: "Mexico", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Mexico"), euMember: false, gdp: 12_000_000, location: locations["mexico"] ?? defaultLocation),
	
	CountryModel(name: "Argentina", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Argentina"), euMember: false, gdp: 12_000_000, location: locations["argentina"] ?? defaultLocation),
	
	CountryModel(name: "Bolivia", description: "Wonderfull Country", flag: UIImage(named: "Flag_of_Bolivia"), euMember: false, gdp: 12_000_000, location: locations["bolivia"] ?? defaultLocation)
 ]]


var sortedEuCountries = countries[0].sorted { $0 < $1 }

var sortedLatinCountries = countries[1].sorted { $0 < $1 }

var sortedCountries = [sortedEuCountries, sortedLatinCountries]


//MARK: sortCountries()
func sortCountries(for section: Int) -> [[CountryModel]] {
	
	if section == 0 {
		
		let newSortedEuCountries = sortedCountries[0].sorted { $0 < $1 }
		return [newSortedEuCountries, sortedCountries[1]]
	} else if section == 1 {
		
		let newSortedLatinCountries = sortedCountries[1].sorted { $0 < $1 }
		return [sortedCountries[0], newSortedLatinCountries]
	} else {
		print("ERORR: sortCountries(section: Int) returned ' [[]] '")
		return [[]] }
}

//MARK: extension Comparable
extension CountryModel: Comparable {
	static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
		lhs.gdp == rhs.gdp
	}

	static func < (lhs: CountryModel, rhs: CountryModel) -> Bool {
		lhs.name < rhs.name
	}
}

// ===============
//MARK: JSON, CODING KEYS

extension CountryModel: Codable {
	
	enum CodingKeys: String, CodingKey {
		case name
		case description
		case flag
		case euMember
		case gdp
		case location
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decode(String.self, forKey: .name)
		description = try values.decode(String.self, forKey: .description)
		let flagData = try values.decode(Data.self, forKey: .flag)
		flag = UIImage(data: flagData)
		euMember = try values.decode(Bool.self, forKey: .euMember)
		gdp = try values.decode(Int.self, forKey: .gdp)
		location = try values.decode(Location.self, forKey: .location)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(description, forKey: .description)

		let flagData = flag?.pngData()
		try container.encode(flagData, forKey: .flag)
		try container.encode(euMember, forKey: .euMember)
		try container.encode(gdp, forKey: .gdp)
		try container.encode(location, forKey: .location)
	}
}
