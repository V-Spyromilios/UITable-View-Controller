//
//  Locations.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.02.23.
//

import Foundation
import MapKit

struct Location: Codable {

	let latitude: Double
	let longitude: Double
	
	init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}
	
	var cllocation: CLLocation {
		return CLLocation(latitude: latitude, longitude: longitude)
	}
}

let defaultLocation = Location(latitude: 0, longitude: 0)

var locations: [String: Location] = [

	"greece" : Location(latitude: 37.9838, longitude: 23.7275),
	"italy" : Location(latitude: 41.9028, longitude: 12.4964),
	"austria" : Location(latitude: 48.2082, longitude: 16.3738),
	"belgium" : Location(latitude: 50.8505, longitude: 4.3488),
	"bulgaria" : Location(latitude: 42.6983, longitude: 23.3199),
	"cyprus" : Location(latitude: 35.1855, longitude: 33.3822),
	"denmark" : Location(latitude: 55.6761, longitude: 12.5683),
	"estonia" : Location(latitude: 59.4370, longitude: 24.7536),
	"finland" : Location(latitude: 60.1699, longitude: 24.9384),
	"france" : Location(latitude: 48.8647, longitude: 2.3490),
	"germany" : Location(latitude: 52.5200, longitude: 13.4049),
	"hungary" : Location(latitude: 47.4979, longitude: 19.0402),
	"ireland" : Location(latitude: 53.3501, longitude:  -6.2661),
	"latvia" : Location(latitude: 56.9677, longitude: 24.1056),
	"lithuania" : Location(latitude: 54.6871, longitude: 25.2796),
	"luxemburg" : Location(latitude: 49.6116, longitude:  6.1319),
	"malta" : Location(latitude: 35.9179, longitude: 14.4099),
	"poland" : Location(latitude: 52.2297, longitude: 21.0122),
	"portugal" : Location(latitude: 38.7223, longitude: 9.1393),
	"romania" : Location(latitude: 44.4396, longitude: 26.0963),
	"slovakia" : Location(latitude: 48.1486, longitude: 17.1077),
	"slovenia" : Location(latitude: 46.05694, longitude: 14.5057),
	"spain" : Location(latitude: 40.4168, longitude: 3.7038),
	"sweden" : Location(latitude: 59.3293, longitude: 18.0686),
	"croatia" : Location(latitude: 45.8153, longitude: 15.9665),
	"czech" : Location(latitude: 50.0736, longitude: 14.4185),
	"netherlands" : Location(latitude: 52.3676, longitude: 4.9041),
	"brazil" : Location(latitude: -15.800, longitude: -47.900),
	"chile" : Location(latitude: 33.4489, longitude: 70.6693),
	"colombia" : Location(latitude:  4.62433, longitude:  -74.0636),
	"costaRica" : Location(latitude: 9.9281, longitude:  84.0907),
	"equador" : Location(latitude: 0.1807, longitude: 78.4678),
	"haiti" : Location(latitude: 18.5333, longitude: -72.3333),
	"mexico" : Location(latitude: 19.4326, longitude: 99.1332),
	"argentina" : Location(latitude: 34.6037, longitude: 58.3816),
	"bolivia" : Location(latitude: 16.4897, longitude: 68.1193)
]
