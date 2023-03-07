//
//  SplitCountryProtocol.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 10.02.23.
//

import Foundation

protocol SplitMasterDetailDelegate: AnyObject {

	func didSelectCountry(country: Country)
}
