//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit

class SplitDetailViewController: UIViewController, MKMapViewDelegate {
	
	var country: Country? {
		didSet {
			setUpDetailView()
			setUpWeatherView()
		}
	}
	
	var location = CLLocation(latitude: 37.4347, longitude: 25.3461)
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var countryNameLabel: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mapView.delegate = self
		mapView.layer.cornerRadius = 9.0
		mapView.layer.borderColor = UIColor.orange.cgColor
		mapView.layer.borderWidth = 5
		
		SplitMasterViewController.delegate = self
	}
	
	
	private func setUpWeatherView() {
		
		let headers = [
			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
		]
		
		let urlLatLong = {
			
			let stringLat = "\(self.country?.latitude ?? 0)"
			let stringLong = "\(self.country?.longitude ?? 0)"
			return "\(stringLat),\(stringLong)"
		}()
		
		
		
		let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers
		
		let configuration = URLSessionConfiguration.default
		configuration.waitsForConnectivity = true
		let session = URLSession.shared
		
		let task: Void = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
			
			guard let httpResponse = response as? HTTPURLResponse else {
				print("PANIC: httpResponse failed to cast")
				return
			}
			if httpResponse.statusCode != 200 {
				print("PANIC HTTP URL RESPONSE != 200")
				return
			}
			guard let data = data else {
				print("PANIC: URLSession:: data -> \(error.debugDescription)")
				return
			}
			do {
				let decoder = JSONDecoder()
				let weather = try decoder.decode(Weather.self, from: data)
			} catch {
				print("PANIC:  JSONDecoder() :: .decode() -> \(error.localizedDescription)")
			}
			
		}).resume()
		
	}
	
	
	private func setUpDetailView() {
		if let name = self.country?.name {
			self.countryNameLabel.text = "\(name)".uppercased()
		} else { self.countryNameLabel.text = "" }
		
		self.location = CLLocation(latitude: country?.latitude ?? 0.0, longitude: country?.longitude ?? 0.0)
		self.mapView.centerToLocation(location: location)
		let annotation = MKPointAnnotation()
		if let gdp = self.country?.gdp {
			annotation.title = "$ \(gdp)"
		}
		else { annotation.title = "NO DATA"}
		annotation.coordinate = CLLocationCoordinate2D(latitude: country?.latitude ?? 0.0, longitude: country?.longitude ?? 0.0)
		self.mapView.addAnnotation(annotation)
		
	}
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		guard annotation is MKPointAnnotation else { return nil }
		
		let identifier = "Annotation"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
		if annotationView == nil {
			annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView!.canShowCallout = true
		} else { annotationView!.annotation = annotation }
		return annotationView
	}
}

extension MKMapView {
	
	func centerToLocation(location: CLLocation, regionRadius: CLLocationDistance = 60000) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		setRegion(coordinateRegion, animated: true)
	}
}

extension SplitDetailViewController: SplitMasterDetailDelegate {
	
	func didSelectCountry(country: Country) {
		self.country = country
	}
	
}

