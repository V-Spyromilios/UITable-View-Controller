//
//  Countries Model.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import Foundation

class CountryModel {
	
	let name: String
	let description: String
	let flag: String?
	let euMember: Bool
	
	init(name: String, description: String, image: String, euMember: Bool) {
		self.name = name
		self.description = description
		self.flag = image
		self.euMember = euMember
	}
}

	let descriptions = CountryDescriptions()
	var countries : [[CountryModel]] = [ [
	
		CountryModel(name: "Greece", description: descriptions.Greece, image: "Flag_of_Greece", euMember: true),
	
		CountryModel(name: "Italy", description: descriptions.Italy, image: "Flag_of_Italy", euMember: true),
	
		CountryModel(name: "Austria", description: descriptions.Austria, image: "Flag_of_Austria", euMember: true),
	
		CountryModel(name: "Belgium", description: descriptions.Belgium, image: "Flag_of_Belgium", euMember: true),
	
		CountryModel(name: "Bulgaria", description: descriptions.Bulgaria, image: "Flag_of_Bulgaria", euMember: true),
	
		CountryModel(name: "Cyprus", description: descriptions.Cyprus, image: "Flag_of_Cyprus", euMember: true),
	
		CountryModel(name: "Denmark", description: descriptions.Denmark, image: "Flag_of_Denmark", euMember: true),
	
		CountryModel(name: "Estonia", description: descriptions.Estonia, image: "Flag_of_Estonia", euMember: true),
	
		CountryModel(name: "Finland", description: descriptions.Finland, image: "Flag_of_Finland", euMember: true),
	
		CountryModel(name: "France", description: descriptions.France, image: "Flag_of_France", euMember: true),
	
		CountryModel(name: "Germany", description: descriptions.Germany, image: "Flag_of_Germany", euMember: true),
	
		CountryModel(name: "Hungary", description: descriptions.Hungary, image: "Flag_of_Hungary", euMember: true),
	
	CountryModel(name: "Ireland", description: "Wonderfull Country", image: "Flag_of_Ireland", euMember: true),
	
	CountryModel(name: "Latvia", description: "Wonderfull Country", image: "Flag_of_Latvia", euMember: true),
	
	CountryModel(name: "Lithuania", description: "Wonderfull Country", image: "Flag_of_Lithuania", euMember: true),
	
	CountryModel(name: "Luxembourg", description: "Wonderfull Country", image: "Flag_of_Luxembourg", euMember: true),
	
	CountryModel(name: "Malta", description: "Wonderfull Country", image: "Flag_of_Malta", euMember: true),
	
	CountryModel(name: "Poland", description: "Wonderfull Country", image: "Flag_of_Poland", euMember: true),
	
	CountryModel(name: "Portugal", description: "Wonderfull Country", image: "Flag_of_Portugal", euMember: true),
	
	CountryModel(name: "Romania", description: "Wonderfull Country", image: "Flag_of_Romania", euMember: true),
	
	CountryModel(name: "Slovakia", description: "Wonderfull Country", image: "Flag_of_Slovakia", euMember: true),
	
	CountryModel(name: "Slovenia", description: "Wonderfull Country", image: "Flag_of_Slovenia", euMember: true),
	
	CountryModel(name: "Spain", description: "Wonderfull Country", image: "Flag_of_Spain", euMember: true),
	
	CountryModel(name: "Sweden", description: "Wonderfull Country", image: "Flag_of_Sweden", euMember: true),
	
	CountryModel(name: "Croatia", description: "Wonderfull Country", image: "Flag_of_Croatia", euMember: true),
	
	CountryModel(name: "Czech Republic", description: "Wonderfull Country", image: "Flag_of_the_Czech_Republic", euMember: true),
	
	CountryModel(name: "Netherlands", description: "Wonderfull Country", image: "Flag_of_the_Netherlands", euMember: true),
	],

	[

	CountryModel(name: "Argentina", description: "Wonderfull Country", image: "Flag_of_Argentina", euMember: false),
	
	CountryModel(name: "Bolivia", description: "Wonderfull Country", image: "Flag_of_Bolivia", euMember: false),
	
	CountryModel(name: "Brazil", description: "Wonderfull Country", image: "Flag_of_Brazil", euMember: false),
	
	CountryModel(name: "Chile", description: "Wonderfull Country", image: "Flag_of_Chile", euMember: false),
	
	CountryModel(name: "Colombia", description: "Wonderfull Country", image: "Flag_of_Colombia", euMember: false),
	
	CountryModel(name: "Costa Rica", description: "Wonderfull Country", image: "Flag_of_Costa_Rica", euMember: false),
	
	CountryModel(name: "Equador", description: "Wonderfull Country", image: "Flag_of_Equador", euMember: false),
	
	CountryModel(name: "Haiti", description: "Wonderfull Country", image: "Flag_of_Haiti", euMember: false),
	
	CountryModel(name: "Mexico", description: "Wonderfull Country", image: "Flag_of_Mexico", euMember: false),
	] ]
