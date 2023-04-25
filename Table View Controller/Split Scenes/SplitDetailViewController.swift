//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//
// Change of var country: Country triggers getWeatherData()  in the background and setMap() on the main.
// getWeatherData() requests data and decodes it to Weather. response is passed to completion handler.
// weatherCompletion, in case of success, detaches getWeatherIcon() and calls the seUpWeatherLabels with the
//  data received from getWeatherData(). getWeatherIcon requests the data, initialises the UIImage and, on
// main thread sets the weatherIcon.image.
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
	
	
	private let privateCountry = BehaviorRelay<Country?>(value: nil)
	var country: Country? {
		didSet {
				var country : Observable<Country?> {
					privateCountry.asObservable()
					//getWeather
				}
		}
	}
	
	var location = CLLocation(latitude: 37.4347, longitude: 25.3461)
	
//	//MARK: weatherCompletion
//	lazy var weatherCompletion : ((Result<Weather, Error>) async -> Void) = { result in
//		print("Inside Weather Completion.") // 8
//		switch result {
//		case .success(let weather):
//			DispatchQueue.global().async {
//				Task.detached {
//					print("Entering getWeatherIcon from detached...")
//					print("\(weather.current.condition.iconUrl)")
//					await self.getWeatherIcon(urlString: weather.current.condition.iconUrl, completion: self.weatherIconCompletion) // After weatherLabels !
//				}
//			}
//			DispatchQueue.main.async {
//				self.setUpWeatherLabels(with: weather)  // before getWeatherIcon
//			}
//		case .failure(let error):
//			print(error)
//		}
//	}

	//MARK: weatherIconCompletion
//	lazy var weatherIconCompletion : ((Result<Data, Error>) -> Void) = { result in
//
//		print("Inside weatherIconCompletion.")
//		switch result {
//		case .failure(let error):
//			print("PANIC: weatherIconCompletion Received Error: \(error)")
//		case .success(let data):
//			Task.detached {
//				DispatchQueue.main.async {
//					self.activityIndicator.stopAnimating()
//					self.weatherIcon.image = UIImage(data: data)
//					print("weatherIconCompletion :: Weather Icon Ready.")
//				}
//			}
//		}
//	}

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
	}
	
	@objc private func showStarWars() {
		self.performSegue(withIdentifier: "swSegue", sender: self)
	}
	
	//MARK: setUpMap
	private func setUpMap() {
		
		print("Inside setUpMap...") // 1
		if let name = self.country?.name {
			self.countryNameLabel.text = "\(name)".uppercased()
		} else { self.countryNameLabel.text = "" }
		
		self.location = CLLocation(latitude: country?.latitude ?? 0.0, longitude: country?.longitude ?? 0.0)
		//print("setUpMap :: Lat: \(self.location.description)")
		self.mapView.centerToLocation(location: location)
		let annotation = MKPointAnnotation()
		if let gdp = self.country?.gdp {
			annotation.title = "$ \(gdp)"
		}
		else { annotation.title = "NO DATA"}
		annotation.coordinate = CLLocationCoordinate2D(latitude: country?.latitude ?? 0.0, longitude: country?.longitude ?? 0.0)
		self.mapView.addAnnotation(annotation)
		print("Map Ready.") // 3
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

extension SplitDetailViewController {

	private func getWeather() {
		guard let country = privateCountry.value else {
			return
		}
		let headers: HTTPHeaders = [
			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
		]
		let urlLatLong = "\(country.latitude),\(country.longitude)"
		let url = "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)"
		
		AF.request(url, headers: headers)
			.validate()
			.responseDecodable(of: Weather.self) { response in
				switch response.result {
				case .success(let weather):
					print("Weather:", weather)
				case .failure(let error):
					print("Error:", error)
				}
		}
	}

	
	//MARK: getWeatherData
//	private func getWeatherData(completion: @escaping (Result<Weather, Error>) async -> Void) async {
//		print("Inside Weather Data...") // 5
//
//		let headers: HTTPHeaders = [
//			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
//			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
//		]
//
//		let urlLatLong = {
//			let stringLat = "\(self.country?.latitude ?? 0)"
//			let stringLong = "\(self.country?.longitude ?? 0)"
//			return "\(stringLat),\(stringLong)"
//		}()
//
//		let url = "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)"
//
//		AF.request(url, headers: headers).validate().responseDecodable(of: Weather.self) { response in
//			Task { // 'Task' as the responseDecodable expects syncronous, here await the completion (is async)
//				switch response.result {
//				case .success(let weatherResponse):
//					let weather = weatherResponse
//					print("Weather Request completed with success. ?!") // 7!
//					await completion(.success(weather))
//					return
//				case .failure(let error):
//					print("PANIC: Weather Request completed with ERROR -> \(error)")
//					await completion(.failure(error))
//					return
//				}
//			}
//		}
//	}
	
	
	//MARK: getWeatherIcon
	private func getWeatherIcon(urlString: String, completion: @escaping ((Result <Data, Error>) -> Void)) async {

		print("Inside getWeatherIcon...") //  ! USUAL POINT OF FREEZING - does not print
		
		let url = URL(string: urlString)
		guard let url = url else {
			print("PANIC: getWeatherIcon() :: 'urlRequest' is nil.")
			return
		}
		
		AF.request(url).validate().responseData { response in //Check above responseDecodable  <-->  responseData
			switch response.result {
			case .failure(let error):
				completion(.failure(error))
				return
			case .success(let data):
				completion(.success(data))
				return
			}
		}
	}
	
	//MARK: setUpWeatherLabels
	private func setUpWeatherLabels(with weather: Weather) {
		
		print("Inside setUpWeatherLabels..") //9
		
		self.temperatureImage.image = UIImage(systemName: "thermometer.medium")?.withRenderingMode(.alwaysTemplate) ?? nil
		self.humidityImage.image = UIImage(systemName: "humidity.fill")?.withRenderingMode(.alwaysTemplate) ?? nil
		self.uvImage.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal) ?? nil
		self.feelsLikeImage.image = UIImage(systemName: "figure.arms.open")?.withRenderingMode(.alwaysTemplate) ?? nil
		self.localtimeImage.image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysTemplate)
		
		self.temperatureImage.tintColor = .red
		self.humidityImage.tintColor = .blue
		self.feelsLikeImage.tintColor = .gray
		self.localtimeImage.tintColor = .blue
		
		self.temperatureLabel.text = String(weather.current.temperature) + " °C"
		self.humidityLabel.text = String(weather.current.humidity) + " %"
		self.feelsLikeLabel.text = String(weather.current.feelsLike) + " °C"
		self.uvLabel.text = String(weather.current.uv)
		
		self.temperatureLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		self.humidityLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		self.feelsLikeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		self.uvLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		
		self.localTimeLabel.text = weather.location.localTime
		self.localTimeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
		
		if weather.current.condition.text != "" {
			self.weatherLabel.text = weather.current.condition.text
		} else { self.weatherLabel.text = "No Data" }
		self.weatherLabel.font = UIFont(name: "George Rounded Bold Italic", size: 22)
		
		self.countryNameLabel.text = "\(weather.location.name)"
		self.countryNameLabel.font = .systemFont(ofSize: 16)
		print("Labels Ready.") // 10
	}
}
