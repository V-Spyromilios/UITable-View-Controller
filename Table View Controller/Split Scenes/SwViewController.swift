//
//  SwViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 21.03.23.
//

import UIKit
import Alamofire

class SwViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var films : Films?
	var characters : swCharacters?
	var pageController: UIPageViewController?
	var contentControllers : [ContentViewController]?
	
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
	
	lazy var charactersCompletion : ((Result<swCharacters, Error>) -> Void)? = { result in
		
		switch result {
		case .success(var characters):
			self.getImages {
				DispatchQueue.main.async {
					self.initPageController(with: characters)
				}
			}
		case .failure(let error):
			print(error)
		}
		
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setUpBackground()
		Task.init {
			do {
				print("awaiting Jsons...")
				await requestJsonFilms(completion: filmsCompletion!)
				await requestJsonCharacters(completion: charactersCompletion!)
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

extension SwViewController: UITableViewDelegate, UITableViewDataSource {
	
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


extension SwViewController {
	
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
	
	private func requestJsonCharacters(completion: @escaping (Result<Character, Error>) -> Void) async {
		
		let urlString = "https://akabab.github.io/starwars-api/api/all.json"
//		"https://intergalacticdb.me/api/characters"
		
		//		do {
		//			let response = try await AF.request(urlString).responseDecodable(of: swCharacters.self)
		//			self.characters = response
		//			completion(.success(response))
		//		} catch {
		//			completion(.failure(error))
		//		}
		
		AF.request(urlString).responseDecodable(of: Character.self) {
			response in
			switch response.result {
			case .success(var swCharacters):
				print(swCharacters)
//				self.characters = swCharacters
				completion(.success(swCharacters))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	private func initPageController(with swCharacters: swCharacters) {
		
		guard let pageController = storyboard?.instantiateViewController(identifier: "PageControllerID") as? UIPageViewController else { return }
		
		pageController.dataSource = self
		pageController.delegate = self
		
		var viewControllers = [ContentViewController]()
		
		for character in swCharacters.characters {
			if let contentViewController = storyboard?.instantiateViewController(identifier: "ContentViewControllerID") as? ContentViewController {
				contentViewController.image = character.image
				contentViewController.name = character.name
				viewControllers.append(contentViewController)
			}
		}

		self.contentControllers = viewControllers
		if let firstViewController = viewControllers.first {
			pageController.setViewControllers([firstViewController], direction: .forward, animated: true)
			addChild(pageController)
			pageController.didMove(toParent: self)
			pageController.dataSource = self
		}
		self.pageController = pageController
	}
	
	private func getImages(completion: @escaping () -> Void) {
		
		guard var characters = self.characters else {
			completion()
			return
		}
		let dispatchGroup = DispatchGroup()
		
		for var character in characters.characters {
			dispatchGroup.enter()
			AF.request(character.imageUrl).responseData { response in
				defer { dispatchGroup.leave() }
				switch response.result {
				case .success(let data):
					character.image = UIImage(data: data)
				case .failure(let error):
					print("getImages() AF response.result = .failure -> \(error)")
				}
			}
		}
		dispatchGroup.notify(queue: .main) {
			completion()
		}
	}
}

extension SwViewController : UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		guard let contentViewController = viewController as? ContentViewController,
			  let currentIndex = self.pageController?.viewControllers?.firstIndex(of: contentViewController),
			  let contentControllers = self.contentControllers,
			  currentIndex < contentControllers.count - 1
		else {
			return self.contentControllers?.first
		}
		
		let nextIndex = currentIndex + 1
		return contentController(at: nextIndex)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let contentViewController = viewController as? ContentViewController,
			  let currentIndex = self.pageController?.viewControllers?.firstIndex(of: contentViewController),
			  currentIndex > 0
		else {
			return nil
		}
		
		let previousIndex = currentIndex - 1
		return contentController(at: previousIndex)
	}
	
	private func contentController(at index: Int) -> ContentViewController? {
		guard let contentControllers = self.contentControllers else { return nil }
		guard index >= 0 && index < contentControllers.count else {
			return nil
		}
		return contentControllers[index]
	}
}

extension SwViewController : UIPageViewControllerDelegate {
	
	
}
