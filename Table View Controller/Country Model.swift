//
//  Countries Model.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//
/// ADD plus button. top right conrner of NavigationBar, to add country by Modal View !!
/// Insert data, image and save to Array
/// save -> Modal view goes away and TableView has to be refreshed.
/// Remove country by swip to left, and update Array.
/// Selecting image -> Go to photos !! (PHPicker)
///
/// Also copy reference types (class - struct)
/// 
/// tableView inside a ViewController instead of TableController
/// use CustomTableViewCells !
/// ADD GDP to both DetailView and TableCell !

import Foundation
import UIKit

struct CountryModel {
	
	var name: String
	var description: String
	var flagName: UIImage?
	var euMember: Bool
	var gdp: Int?
}

let descriptions = CountryDescriptions()

var countries : [[CountryModel]] = [ [
	
	CountryModel(name: "Greece", description: descriptions.greece, flagName: UIImage(named: "Flag_of_Greece") , euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Italy", description: descriptions.italy, flagName: UIImage(named: "Flag_of_Italy"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Austria", description: descriptions.austria, flagName: UIImage(named: "Flag_of_Austria"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Belgium", description: descriptions.belgium, flagName: UIImage(named: "Flag_of_Belgium"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Bulgaria", description: descriptions.bulgaria, flagName: UIImage(named: "Flag_of_Bulgaria"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Cyprus", description: descriptions.cyprus, flagName: UIImage(named: "Flag_of_Cyprus"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Denmark", description: descriptions.denmark, flagName: UIImage(named: "Flag_of_Denmark"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Estonia", description: descriptions.estonia, flagName: UIImage(named: "Flag_of_Estonia"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Finland", description: descriptions.finland, flagName: UIImage(named: "Flag_of_Finland"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "France", description: descriptions.france, flagName: UIImage(named: "Flag_of_France"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Germany", description: descriptions.germany, flagName: UIImage(named: "Flag_of_Germany"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Hungary", description: descriptions.hungary, flagName: UIImage(named: "Flag_of_Hungary"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Ireland", description: descriptions.ireland, flagName: UIImage(named: "Flag_of_Ireland"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Latvia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Latvia"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Lithuania", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Lithuania"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Luxembourg", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Luxembourg"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Malta", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Malta"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Poland", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Poland"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Portugal", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Portugal"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Romania", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Romania"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Slovakia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Slovakia"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Slovenia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Slovenia"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Spain", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Spain"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Sweden", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Sweden"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Croatia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Croatia"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Czech Republic", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_the_Czech_Republic"), euMember: true, gdp: 12_000_000),
	
	CountryModel(name: "Netherlands", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_the_Netherlands"), euMember: true, gdp: 12_000_000),
],

 [
	CountryModel(name: "Brazil", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Brazil"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Chile", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Chile"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Colombia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Colombia"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Costa Rica", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Costa_Rica"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Equador", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Equador"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Haiti", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Haiti"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Mexico", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Mexico"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Argentina", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Argentina"), euMember: false, gdp: 12_000_000),
	
	CountryModel(name: "Bolivia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Bolivia"), euMember: false, gdp: 12_000_000)
 ]]


var sortedEuCountries = countries[0].sorted { $0.name < $1.name }

var sortedLatinCountries = countries[1].sorted { $0.name < $1.name }

var sortedCountries = [sortedEuCountries, sortedLatinCountries]


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

extension CountryModel: Comparable {

	static func < (lhs: CountryModel, rhs: CountryModel) -> Bool {
		lhs.name < rhs.name
	}
}
