//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit
import Alamofire

class SplitDetailViewController: UIViewController, MKMapViewDelegate {
	
	
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

	
	var country: Country? {
		didSet {
			Task.init {
				print("Waiting Weather Data...")
				//TODO: change requestWeatherData() to completion Handler
				await getWeatherData(completion: weatherCompletion)
				print("Weather Data Received, getting the Weather Icon..")
			}
			DispatchQueue.main.async {
				self.setUpMap()
			}
		}
	}
	
	var location = CLLocation(latitude: 37.4347, longitude: 25.3461)

	//MARK: weatherCompletion
	lazy var weatherCompletion : ((Result<Weather, Error>) -> Void) = { result in

		switch result {
			case .success(let weather):
				Task {
					do {
						await self.getWeatherIcon(urlString: weather.current.condition.iconUrl)
						DispatchQueue.main.async {
							self.setUpWeatherLabels(with: weather)
						}
					}
				}
			case .failure(let error):
				print(error)
			}
		}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		
		let rightButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(showSW))
		rightButton.tintColor = .black
		self.navigationItem.setRightBarButton(rightButton, animated: true)
		
	}
	
	@objc private func showSW() {
		self.performSegue(withIdentifier: "swSegue", sender: self)
	}
	
	private func setUpMap() {

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

// fetch weather json
extension SplitDetailViewController {

	//MARK: getWeatherData
	private func getWeatherData(completion: @escaping (Result<Weather, Error>) -> Void) async {
		print("Getting Weather info...")
		
		let headers: HTTPHeaders = [
			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
		]
		
		let urlLatLong = {
			let stringLat = "\(self.country?.latitude ?? 0)"
			let stringLong = "\(self.country?.longitude ?? 0)"
			return "\(stringLat),\(stringLong)"
		}()
		
		let url = "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)"
		
		AF.request(url, headers: headers).validate().responseDecodable(of: Weather.self) { response in
			switch response.result {
			case .success(let weatherResponse):
				let weather = weatherResponse
				print("Weather Rquest completed.")
				completion(.success(weather))
			case .failure(let error):
				print("PANIC: \(error)")
				completion(.failure(error))
			}
		}
	}


	//MARK: getWeatherIcon
	private func getWeatherIcon(urlString: String) async {
		print("Getting Weather Icon..")
		
		var weatherImage : UIImage?
		
//		guard let weather = weather else {
//			print("PANIC: getWeatherIcon() :: 'weather' is nil.")
//			return
//		}
		
		let urlRequest = URL(string: urlString)
		guard let urlRequest = urlRequest else 	{
			print("PANIC: getWeatherIcon() :: 'urlRequest' is nil.")
			return
		}
		var request = URLRequest(url: urlRequest)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = [:]
		
		let configuration = URLSessionConfiguration.default
		configuration.waitsForConnectivity = true
		let session = URLSession.shared
		
		do {
			let (data, response) = try await session.data(for: request)
			guard let httpsResponse = response as? HTTPURLResponse,
				  httpsResponse.statusCode == 200 else {
				print("PANIC: httpsResponse.statusCode != 200")
				return
			}
			weatherImage = UIImage(data: data)
		} catch {
			print("PANIC: getWeatherIcon() :: failed to get weatherIcon Data")
			return
		}
		DispatchQueue.main.async {
			print(" Weather Icon Ready..")
			self.weatherIcon.image = weatherImage
		}
	}

//MARK: setUpWeatherLabels
	private func setUpWeatherLabels(with weather: Weather) {
		
		print("Setting Up Weather Labels..")
		
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
		print("Labels Ready.")
	}
}
