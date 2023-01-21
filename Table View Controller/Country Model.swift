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
/// Also copy reference types (class - struct)
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
}

let descriptions = CountryDescriptions()

var countries : [[CountryModel]] = [ [
	
	//CountryModel(name: "Greece", description: descriptions.greece, flagName: "Flag_of_Greece", euMember: true),
	CountryModel(name: "Greece", description: descriptions.greece, flagName: UIImage(named: "Flag_of_Greece") , euMember: true),
	
	CountryModel(name: "Italy", description: descriptions.italy, flagName: UIImage(named: "Flag_of_Italy"), euMember: true),
	
	CountryModel(name: "Austria", description: descriptions.austria, flagName: UIImage(named: "Flag_of_Austria"), euMember: true),
	
	CountryModel(name: "Belgium", description: descriptions.belgium, flagName: UIImage(named: "Flag_of_Belgium"), euMember: true),
	
	CountryModel(name: "Bulgaria", description: descriptions.bulgaria, flagName: UIImage(named: "Flag_of_Bulgaria"), euMember: true),
	
	CountryModel(name: "Cyprus", description: descriptions.cyprus, flagName: UIImage(named: "Flag_of_Cyprus"), euMember: true),
	
	CountryModel(name: "Denmark", description: descriptions.denmark, flagName: UIImage(named: "Flag_of_Denmark"), euMember: true),
	
	CountryModel(name: "Estonia", description: descriptions.estonia, flagName: UIImage(named: "Flag_of_Estonia"), euMember: true),
	
	CountryModel(name: "Finland", description: descriptions.finland, flagName: UIImage(named: "Flag_of_Finland"), euMember: true),
	
	CountryModel(name: "France", description: descriptions.france, flagName: UIImage(named: "Flag_of_France"), euMember: true),
	
	CountryModel(name: "Germany", description: descriptions.germany, flagName: UIImage(named: "Flag_of_Germany"), euMember: true),
	
	CountryModel(name: "Hungary", description: descriptions.hungary, flagName: UIImage(named: "Flag_of_Hungary"), euMember: true),
	
	CountryModel(name: "Ireland", description: descriptions.ireland, flagName: UIImage(named: "Flag_of_Ireland"), euMember: true),
	
	CountryModel(name: "Latvia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Latvia"), euMember: true),
	
	CountryModel(name: "Lithuania", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Lithuania"), euMember: true),
	
	CountryModel(name: "Luxembourg", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Luxembourg"), euMember: true),
	
	CountryModel(name: "Malta", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Malta"), euMember: true),
	
	CountryModel(name: "Poland", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Poland"), euMember: true),
	
	CountryModel(name: "Portugal", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Portugal"), euMember: true),
	
	CountryModel(name: "Romania", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Romania"), euMember: true),
	
	CountryModel(name: "Slovakia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Slovakia"), euMember: true),
	
	CountryModel(name: "Slovenia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Slovenia"), euMember: true),
	
	CountryModel(name: "Spain", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Spain"), euMember: true),
	
	CountryModel(name: "Sweden", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Sweden"), euMember: true),
	
	CountryModel(name: "Croatia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Croatia"), euMember: true),
	
	CountryModel(name: "Czech Republic", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_the_Czech_Republic"), euMember: true),
	
	CountryModel(name: "Netherlands", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_the_Netherlands"), euMember: true),
],

[
	
	CountryModel(name: "Argentina", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Argentina"), euMember: false),
	
	CountryModel(name: "Bolivia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Bolivia"), euMember: false),
	
	CountryModel(name: "Brazil", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Brazil"), euMember: false),
	
	CountryModel(name: "Chile", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Chile"), euMember: false),
	
	CountryModel(name: "Colombia", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Colombia"), euMember: false),
	
	CountryModel(name: "Costa Rica", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Costa_Rica"), euMember: false),
	
	CountryModel(name: "Equador", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Equador"), euMember: false),
	
	CountryModel(name: "Haiti", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Haiti"), euMember: false),
	
	CountryModel(name: "Mexico", description: "Wonderfull Country", flagName: UIImage(named: "Flag_of_Mexico"), euMember: false),
]]
