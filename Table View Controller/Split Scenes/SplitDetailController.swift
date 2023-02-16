//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit

class SplitDetailController: UIViewController, MKMapViewDelegate, UISplitViewControllerDelegate {
	
	var country: CountryModel?
	
	var location = CLLocation(latitude: 37.4347, longitude: 25.3461)
	
	@IBOutlet weak var mapView: MKMapView!
	
	@IBOutlet weak var countryNameLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "Paparies2"
		
		//SplitViewController.delegate = self
		
		mapView.delegate = self
		mapView.layer.cornerRadius = 9.0
		mapView.layer.borderColor = UIColor.orange.cgColor
		mapView.layer.borderWidth = 5
	}
}

extension SplitDetailController: splitCountryProtocol {
	
	func sendCountryToDetailView(country: CountryModel) {

		self.country = country
		self.countryNameLabel.text = country.name.uppercased() + " GDP"
		self.location = self.country?.location.cllocation ?? CLLocation(latitude: 37.4347, longitude: 25.3461)
		self.mapView.centerToLocation(location: location)
		let annotation = MKPointAnnotation()
		if country.gdp != nil {
			annotation.title = "$ \(country.gdp!)"
		}
		else { annotation.title = "NO DATA"}
		annotation.coordinate = CLLocationCoordinate2D(latitude: country.location.latitude, longitude: country.location.longitude)

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

	func centerToLocation(location: CLLocation, regionRadius: CLLocationDistance = 50000) {
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		setRegion(coordinateRegion, animated: true)
	}
}
