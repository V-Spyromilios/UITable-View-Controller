//
//  swCharacters.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.04.23.
//

import Foundation
import UIKit

struct swCharacters : Decodable {

	var characters : [Character]
}

struct Character: Decodable {

	let name : String
	let imageUrl : String
	var image: UIImage?

	enum CodingKeys : String, CodingKey {

		case name
		case imageUrl = "image"
	}

	init(from decoder: Decoder) throws {

		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.name = try container.decode(String.self, forKey: .name)
		let httpString = try container.decode(String.self, forKey: .imageUrl)
//		let httpsString = httpString.replacingOccurrences(of: "http", with: "https")
		self.imageUrl = httpString
	}
}

