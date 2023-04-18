//
//  SwViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 21.03.23.
//

import UIKit
import Alamofire

class StarWarsViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	var films : Films?
	lazy var filmsCompletion : ((Result<Films, Error>) -> Void)? = { result in

		switch result {
		case .success(let films):
			DispatchQueue.main.async {
				self.films = films
				self.tableView.delegate = self
				self.tableView.dataSource = self
				self.tableView.reloadData()
			}
		case .failure(let error):
			print(error)
		}
	}
	
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()

		setUpBackground()
		Task.init {
			do {
				await requestJsonFilms(completion: filmsCompletion!)
			}
		}
	}
	
	private func setUpBackground() {
		
		let backgroundImage = UIImageView(frame: self.view.bounds)
		backgroundImage.image = UIImage(named: "Andromeda_Galaxy")
		backgroundImage.contentMode = .scaleAspectFill
		backgroundImage.clipsToBounds = true
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(backgroundImage)
		self.view.sendSubviewToBack(backgroundImage)
	}
}

//MARK: TableView DataSource & Delegate
extension StarWarsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return films?.movies.count ?? 0
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "swTableCell", for: indexPath) as! SwTableViewCell
		if let films = self.films {
			let selectedItem = films.movies[indexPath.row]
			
			cell.updateCustomSwCell(with: selectedItem)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		guard let indexPath = tableView.indexPathForSelectedRow else { return }
		
		guard let selectedMovie = self.films?.movies[indexPath.row] else { return }
		let crawlVC = storyboard?.instantiateViewController(withIdentifier: "crawlIdentifier") as! CrawlViewController
		
		crawlVC.crawl = selectedMovie.crawl
		self.tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(crawlVC, animated: true)
	}
}


//MARK: request Films
extension StarWarsViewController {
	
	private func requestJsonFilms(completion: @escaping (Result<Films, Error>) -> Void) async {
		
		let urlString = "https://swapi.dev/api/films"
		
		AF.request(urlString).responseDecodable(of: Films.self) { //from url to struct !
			response in
			switch response.result {
			case .success(let films):
				completion(.success(films))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
