//
//  SplitSecondaryViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import MapKit


class SplitDetailViewController: UIViewController, MKMapViewDelegate {
	
	
	@IBOutlet weak var temperatureImage: UIImageView!
	@IBOutlet weak var temperatureLabel: UILabel!
	
	@IBOutlet weak var feelsLikeImage: UIImageView!
	@IBOutlet weak var feelsLikeLabel: UILabel!
	
	@IBOutlet weak var humidityImage: UIImageView!
	@IBOutlet weak var humidityLabel: UILabel!
	
	
	@IBOutlet weak var uvImage: UIImageView!
	@IBOutlet weak var uvLabel: UILabel!
	
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var countryNameLabel: UILabel!
	
	
	@IBOutlet weak var localtimeImage: UIImageView!
	@IBOutlet weak var localTimeLabel: UILabel!
	
	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var weatherLabel: UILabel!
	
	
	var country: Country? {
		didSet {
			setUpDetailView()
			pullWeatherData()
		}
	}
	
	var location = CLLocation(latitude: 37.4347, longitude: 25.3461)
	var weather: Weather?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mapView.delegate = self
		mapView.layer.cornerRadius = 9.0
		mapView.layer.borderColor = UIColor.orange.cgColor
		mapView.layer.borderWidth = 5
		
		SplitMasterViewController.delegate = self
		
		temperatureImage.image = UIImage(systemName: "thermometer.medium")?.withRenderingMode(.alwaysTemplate) ?? nil
		humidityImage.image = UIImage(systemName: "humidity.fill")?.withRenderingMode(.alwaysTemplate) ?? nil
		uvImage.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal) ?? nil
		feelsLikeImage.image = UIImage(systemName: "figure.arms.open")?.withRenderingMode(.alwaysTemplate) ?? nil
		localtimeImage.image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysTemplate)
		
		self.temperatureImage.tintColor = .red
		self.humidityImage.tintColor = .blue
		self.feelsLikeImage.tintColor = .gray
		self.localtimeImage.tintColor = .blue
	}
	
	
	private func pullWeatherData() {
		
		let headers = [
			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
		]
		
		let urlLatLong = {
			
			let stringLat = "\(self.country?.latitude ?? 0)"
			let stringLong = "\(self.country?.longitude ?? 0)"
			//TODO: if long/ lang nil setUpNilLabels()
			return "\(stringLat),\(stringLong)"
		}()
		guard let urlRequest = URL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)") else { return }
		var request = URLRequest(url: urlRequest)
//
//		let request = NSMutableURLRequest(url: NSURL(string: "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers
		
//		request.addValue("weatherapi-com.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
		
		let configuration = URLSessionConfiguration.default
		configuration.waitsForConnectivity = true
		let session = URLSession.shared
		
			let _: Void = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
				
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
//						do {
//							let decoder = JSONDecoder()
//							self.weather = try decoder.decode(Weather.self, from: data)
//						} catch {
//							print("PANIC:  JSONDecoder() :: .decode() -> \(error.localizedDescription)")
//						}
			do {
				let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

				let weatherData = try JSONSerialization.data(withJSONObject: json?["current"] ?? [:], options: [])
				let locationData = try JSONSerialization.data(withJSONObject: json?["location"] ?? [:], options: [])

				let decoder = JSONDecoder()
				let current = try decoder.decode(Current.self, from: weatherData)
				let location = try decoder.decode(Location.self, from: locationData)

				self.weather = Weather(current: current, location: location)
				
				if let weather = self.weather {
					self.setUpLabels(with: weather)
				}
			} catch {
				print("PANIC: Failed to decode weather data -> \(error)")
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
	
	private func setUpLabels(with weather: Weather) {
		
		var weatherimage : UIImage?
		
		if let imageUrl = URL(string: weather.current.condition.iconUrl),
		   let imageData = try? Data(contentsOf: imageUrl) {
			weatherimage = UIImage(data: imageData)
		}
		DispatchQueue.main.async {
			
			if let weatherimage = weatherimage {
				self.weatherIcon.image = weatherimage
			} else { self.weatherIcon.image = UIImage(systemName: "cloud.sun") }
			
			self.temperatureLabel.text = String(weather.current.temperature) + " °C"
			self.humidityLabel.text = String(weather.current.humidity) + " %"
			self.feelsLikeLabel.text = String(weather.current.feelsLike) + " °C"
			self.uvLabel.text = String(weather.current.uv)
			
			self.temperatureLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
			self.humidityLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
			self.feelsLikeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
			self.uvLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
			
			let localTime = weather.location.localTime.components(separatedBy: " ").last
			if let localTime = localTime {
				self.localTimeLabel.text = localTime
			}
			self.localTimeLabel.font = UIFont(name: "George Rounded Bold Italic", size: 20)
			
			if weather.current.condition.text != "" {
				self.weatherLabel.text = weather.current.condition.text
			} else { self.weatherLabel.text = "No Data" }
			self.weatherLabel.font = UIFont(name: "George Rounded Bold Italic", size: 22)
			
				self.countryNameLabel.text = "\(weather.location.name)"
			self.countryNameLabel.font = .systemFont(ofSize: 16)
			
		}
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

