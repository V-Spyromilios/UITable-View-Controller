//
//  Locations.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.02.23.
//

import Foundation
import MapKit

//struct Location: Codable {
//
//	let latitude: Double
//	let longitude: Double
//	
//	init(latitude: Double, longitude: Double) {
//		self.latitude = latitude
//		self.longitude = longitude
//	}
//
//	var cllocation: CLLocation {
//		return CLLocation(latitude: latitude, longitude: longitude)
//	}
//}
//
//let defaultLocation = Location(latitude: 0, longitude: 0)

var locations: [String: (latitude: Double, longitude: Double)] = [

	"greece" : (latitude: 37.9838, longitude: 23.7275),
	"italy" : (latitude: 41.9028, longitude: 12.4964),
	"austria" : (latitude: 48.2082, longitude: 16.3738),
	"belgium" : (latitude: 50.8505, longitude: 4.3488),
	"bulgaria" : (latitude: 42.6983, longitude: 23.3199),
	"cyprus" : (latitude: 35.1855, longitude: 33.3822),
	"denmark" : (latitude: 55.6761, longitude: 12.5683),
	"estonia" : (latitude: 59.4370, longitude: 24.7536),
	"finland" : (latitude: 60.1699, longitude: 24.9384),
	"france" : (latitude: 48.8647, longitude: 2.3490),
	"germany" : (latitude: 52.5200, longitude: 13.4049),
	"hungary" : (latitude: 47.4979, longitude: 19.0402),
	"ireland" : (latitude: 53.3501, longitude:  -6.2661),
	"latvia" : (latitude: 56.9677, longitude: 24.1056),
	"lithuania" : (latitude: 54.6871, longitude: 25.2796),
	"luxemburg" : (latitude: 49.6116, longitude:  6.1319),
	"malta" : (latitude: 35.9179, longitude: 14.4099),
	"poland" : (latitude: 52.2297, longitude: 21.0122),
	"portugal" : (latitude: 38.7223, longitude: 9.1393),
	"romania" : (latitude: 44.4396, longitude: 26.0963),
	"slovakia" : (latitude: 48.1486, longitude: 17.1077),
	"slovenia" : (latitude: 46.05694, longitude: 14.5057),
	"spain" : (latitude: 40.4168, longitude: 3.7038),
	"sweden" : (latitude: 59.3293, longitude: 18.0686),
	"croatia" : (latitude: 45.8153, longitude: 15.9665),
	"czech" : (latitude: 50.0736, longitude: 14.4185),
	"netherlands" : (latitude: 52.3676, longitude: 4.9041),
	"brazil" : (latitude: -15.800, longitude: -47.900),
	"chile" : (latitude: 33.4489, longitude: 70.6693),
	"colombia" : (latitude:  4.62433, longitude:  -74.0636),
	"costaRica" : (latitude: 9.9281, longitude:  84.0907),
	"equador" : (latitude: 0.1807, longitude: 78.4678),
	"haiti" : (latitude: 18.5333, longitude: -72.3333),
	"mexico" : (latitude: 19.4326, longitude: 99.1332),
	"argentina" : (latitude: 34.6037, longitude: 58.3816),
	"bolivia" : (latitude: 16.4897, longitude: 68.1193)
]
