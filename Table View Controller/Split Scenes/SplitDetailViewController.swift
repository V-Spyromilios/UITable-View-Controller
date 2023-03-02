//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit

class SplitDetailViewController: UIViewController, MKMapViewDelegate {
	
	var country: CountryTemp? {
		didSet {
			setUpDetailView()
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
	
	
	private func setUpDetailView() {
		self.countryNameLabel.text = (self.country?.name.uppercased())! + " GDP"
		self.location = self.country?.location.cllocation ?? CLLocation(latitude: 0.0, longitude: 0.0)
		self.mapView.centerToLocation(location: location)
		let annotation = MKPointAnnotation()
		if let gdp = self.country?.gdp {
			annotation.title = "$ \(gdp)"
		}
		else { annotation.title = "NO DATA"}
		annotation.coordinate = CLLocationCoordinate2D(latitude: country?.location.latitude ?? 0.0, longitude: country?.location.longitude ?? 0.0)
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

	func didSelectCountry(country: CountryTemp) {
		self.country = country
	}

}
