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

	let constants = Constants()
	var countries : [[CountryModel]] = [ [
	
		CountryModel(name: "Greece", description: constants.Greece, image: "Flag_of_Greece", euMember: true),
	
	CountryModel(name: "Italy", description: "Fiat and Ferrari", image: "Flag_of_Italy", euMember: true),
	
	CountryModel(name: "Austria", description: "Bourdelo me thea", image: "Flag_of_Austria", euMember: true),
	
	CountryModel(name: "Belgium", description: "Bourdelo me thea", image: "Flag_of_Belgium", euMember: true),
	
	CountryModel(name: "Bulgaria", description: "Bourdelo me thea", image: "Flag_of_Bulgaria", euMember: true),
	
	CountryModel(name: "Cyprus", description: "Bourdelo me thea", image: "Flag_of_Cyprus", euMember: true),
	
	CountryModel(name: "Denmark", description: "Bourdelo me thea", image: "Flag_of_Denmark", euMember: true),
	
	CountryModel(name: "Estonia", description: "Bourdelo me thea", image: "Flag_of_Estonia", euMember: true),
	
	CountryModel(name: "Finland", description: "Bourdelo me thea", image: "Flag_of_Finland", euMember: true),
	
	CountryModel(name: "France", description: "Bourdelo me thea", image: "Flag_of_France", euMember: true),
	
	CountryModel(name: "Germany", description: "Bourdelo me thea", image: "Flag_of_Germany", euMember: true),
	
	CountryModel(name: "Hungary", description: "Bourdelo me thea", image: "Flag_of_Hungary", euMember: true),
	
	CountryModel(name: "Ireland", description: "Bourdelo me thea", image: "Flag_of_Ireland", euMember: true),
	
	CountryModel(name: "Latvia", description: "Bourdelo me thea", image: "Flag_of_Latvia", euMember: true),
	
	CountryModel(name: "Lithuania", description: "Bourdelo me thea", image: "Flag_of_Lithuania", euMember: true),
	
	CountryModel(name: "Luxembourg", description: "Bourdelo me thea", image: "Flag_of_Luxembourg", euMember: true),
	
	CountryModel(name: "Malta", description: "Bourdelo me thea", image: "Flag_of_Malta", euMember: true),
	
	CountryModel(name: "Poland", description: "Bourdelo me thea", image: "Flag_of_Poland", euMember: true),
	
	CountryModel(name: "Portugal", description: "Bourdelo me thea", image: "Flag_of_Portugal", euMember: true),
	
	CountryModel(name: "Romania", description: "Bourdelo me thea", image: "Flag_of_Romania", euMember: true),
	
	CountryModel(name: "Slovakia", description: "Bourdelo me thea", image: "Flag_of_Slovakia", euMember: true),
	
	CountryModel(name: "Slovenia", description: "Bourdelo me thea", image: "Flag_of_Slovenia", euMember: true),
	
	CountryModel(name: "Spain", description: "Bourdelo me thea", image: "Flag_of_Spain", euMember: true),
	
	CountryModel(name: "Sweden", description: "Bourdelo me thea", image: "Flag_of_Sweden", euMember: true),
	
	CountryModel(name: "Croatia", description: "Bourdelo me thea", image: "Flag_of_Croatia", euMember: true),
	
	CountryModel(name: "Czech Republic", description: "Bourdelo me thea", image: "Flag_of_the_Czech_Republic", euMember: true),
	
	CountryModel(name: "Netherlands", description: "Bourdelo me thea", image: "Flag_of_the_Netherlands", euMember: true),
	],

	[

	CountryModel(name: "Argentina", description: "Bourdelo me thea", image: "Flag_of_Argentina", euMember: false),
	
	CountryModel(name: "Bolivia", description: "Bourdelo me thea", image: "Flag_of_Bolivia", euMember: false),
	
	CountryModel(name: "Brazil", description: "Bourdelo me thea", image: "Flag_of_Brazil", euMember: false),
	
	CountryModel(name: "Chile", description: "Bourdelo me thea", image: "Flag_of_Chile", euMember: false),
	
	CountryModel(name: "Colombia", description: "Bourdelo me thea", image: "Flag_of_Colombia", euMember: false),
	
	CountryModel(name: "Costa Rica", description: "Bourdelo me thea", image: "Flag_of_Costa_Rica", euMember: false),
	
	CountryModel(name: "Equador", description: "Bourdelo me thea", image: "Flag_of_Equador", euMember: false),
	
	CountryModel(name: "Haiti", description: "Bourdelo me thea", image: "Flag_of_Haiti", euMember: false),
	
	CountryModel(name: "Mexico", description: "Bourdelo me thea", image: "Flag_of_Mexico", euMember: false),
	] ]
