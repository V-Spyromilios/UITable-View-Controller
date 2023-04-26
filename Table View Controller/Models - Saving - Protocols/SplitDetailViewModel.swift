//
//  SplitViewViewModel.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 25.04.23.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


class SplitDetailViewModel {
	
	let country: BehaviorRelay<Country?> = BehaviorRelay(value: nil)
	let weather: BehaviorRelay<Weather?> = BehaviorRelay(value: nil)
	private let bag = DisposeBag()
	
	init() {
		createBindings()
	}
	
	private func createBindings() {
		
		country.subscribe(onNext: { country in
			self.getWeatherData { weather in
				self.weather.accept(weather)
			}
		}).disposed(by: bag)
	}

	private func getWeatherData(completion: ((Weather?) -> Void)?) {
		
		let headers: HTTPHeaders = [
			"X-RapidAPI-Key": "edeaab50d3msh5e66efba0a15f63p1f78d8jsnb42899463a43",
			"X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
		]
		
		let urlLatLong = "\(country.value?.latitude ?? 0),\(country.value?.longitude ?? 0)"
		let url = "https://weatherapi-com.p.rapidapi.com/current.json?q=\(urlLatLong)"
		
		AF.request(url, headers: headers)
			.validate()
			.responseDecodable(of: Weather.self) { response in
				switch response.result {
				case .success(let weather):
					completion?(weather)
				case .failure(let error):
					print("\(error)")
					completion?(nil)
				}
			}
	}

}
