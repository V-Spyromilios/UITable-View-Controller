//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit
import Alamofire
import RxSwift
import RxCocoa


class SplitDetailViewController: UIViewController, MKMapViewDelegate {
	
	@IBOutlet weak var activityIndicator : UIActivityIndicatorView!
	
	@IBOutlet weak var temperatureImage: UIImageView!
	@IBOutlet weak var temperatureLabel: UILabel!
	
	@IBOutlet weak var feelsLikeImage: UIImageView!
	@IBOutlet weak var feelsLikeLabel: UILabel!
	
	@IBOutlet weak var humidityImage: UIImageView!
	@IBOutlet weak var humidityLabel: UILabel!
	
	@IBOutlet weak var uvImage: UIImageView!
	@IBOutlet weak var uvLabel: UILabel!
	
	@IBOutlet weak var localtimeImage: UIImageView!
	@IBOutlet weak var localTimeLabel: UILabel!
	
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var weatherLabel: UILabel!
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var countryNameLabel: UILabel!
	
	
	fileprivate let viewModel = SplitDetailViewModel()
	private let bag = DisposeBag()
	
	var isCountrySet: Bool { viewModel.country.value != nil }
	
	
	//MARK: viewDidLoad
	override func viewDidLoad() {

		super.viewDidLoad()
		activityIndicator.color = .orange
		activityIndicator.hidesWhenStopped = true
		
		let backButton = UIBarButtonItem()
		let swColor = UIColor(red: 255/255, green: 232/255, blue: 31/255, alpha: 0.8)
		backButton.tintColor = swColor
		backButton.title = "Earth"
		navigationItem.backBarButtonItem = backButton
		
		mapView.delegate = self
		mapView.layer.cornerRadius = 9.0
		mapView.layer.borderColor = UIColor.orange.cgColor
		mapView.layer.borderWidth = 5
		
		SplitMasterViewController.delegate = self
		
		let rightButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(showStarWars))
		rightButton.tintColor = .black
		self.navigationItem.setRightBarButton(rightButton, animated: true)
		
		setUpUI()
		createBindings()
	}

	@objc private func showStarWars() {
		self.performSegue(withIdentifier: "swSegue", sender: self)
	}

	//MARK: createBindings
	private func createBindings() {
		
		viewModel.weather.observe(on: MainScheduler.instance).subscribe(onNext: { weather in
			self.setUpWeatherLabels(with: weather)
			self.getWeatherIcon(weather: weather)
		}).disposed(by: bag)
		
		viewModel.country.observe(on: MainScheduler.instance).subscribe(onNext: { country in
			self.setUpMap(country: country)
		}).disposed(by: bag)
	}

	//MARK: setUpMap
	private func setUpMap(country: Country?) {

		if let name = country?.name {
			self.countryNameLabel.text = "\(name)".uppercased()
		} else { self.countryNameLabel.text = "" }
		
		let location = CLLocation(latitude: country?.latitude ?? 0.0, longitude: country?.longitude ?? 0.0)
		self.mapView.centerToLocation(location: location)
		let annotation = MKPointAnnotation()
		if let gdp = country?.gdp {
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

	//MARK: didSelectCountry (Delegate)
extension SplitDetailViewController: SplitMasterDetailDelegate {
	
	func didSelectCountry(country: Country) {
		viewModel.country.accept(country)
	}
}

extension SplitDetailViewController {

	//MARK: getWeatherIcon
	private func getWeatherIcon(weather: Weather?) {
		
		guard let urlString = weather?.current.condition.iconUrl,
			  let url = URL(string: urlString) else { return }
		
		DispatchQueue.global().async {
			guard let data = try? Data(contentsOf: url)  else { return }
			DispatchQueue.main.async {
				self.weatherIcon.image = UIImage(data: data)
			}
		}
	}

	//MARK: seyUpUI
	private func setUpUI() {
		
		temperatureImage.image = UIImage(systemName: "thermometer.medium")?.withRenderingMode(.alwaysTemplate) ?? nil
		humidityImage.image = UIImage(systemName: "humidity.fill")?.withRenderingMode(.alwaysTemplate) ?? nil
		uvImage.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal) ?? nil
		feelsLikeImage.image = UIImage(systemName: "figure.arms.open")?.withRenderingMode(.alwaysTemplate) ?? nil
		localtimeImage.image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysTemplate)
		
		temperatureImage.tintColor = .red
		humidityImage.tintColor = .blue
		feelsLikeImage.tintColor = .gray
		localtimeImage.tintColor = .blue
		
		temperatureLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		humidityLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		feelsLikeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		uvLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		localTimeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		weatherLabel.font = UIFont(name: "George Rounded Bold Italic", size: 22)
		countryNameLabel.font = .systemFont(ofSize: 16)
	}
	
	//MARK: setUpWeatherLabels
	private func setUpWeatherLabels(with weather: Weather?) {
		
		guard let weather = weather else {
			setUpEmptyLabels()
			return
		}
		self.temperatureLabel.text = String(weather.current.temperature) + " °C"
		self.humidityLabel.text = String(weather.current.humidity) + " %"
		self.feelsLikeLabel.text = String(weather.current.feelsLike) + " °C"
		self.uvLabel.text = String(weather.current.uv)
		self.localTimeLabel.text = weather.location.localTime
		self.countryNameLabel.text = "\(weather.location.name)"
		self.weatherLabel.text = weather.current.condition.text
	}

	//MARK: setUpEmptyLabels
	private func setUpEmptyLabels() {
		
		self.temperatureLabel.text = ""
		self.humidityLabel.text = ""
		self.feelsLikeLabel.text = ""
		self.uvLabel.text = ""
		self.localTimeLabel.text = ""
		self.countryNameLabel.text = ""
		self.weatherLabel.text = ""
	}
}
