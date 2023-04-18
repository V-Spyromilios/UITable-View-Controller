//
//  PageController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 17.04.23.
//

import UIKit
import Alamofire

class PageController : UIPageViewController {
	
	@IBOutlet weak var pageControl: UIPageControl!

	fileprivate var pages = [PageViewController]()
	fileprivate var receivedCharacters = [Character]()
	
	//MARK: charactersCompletion
	lazy var charactersCompletion: ((Result<[Character], Error>) -> Void)? = { result in
		
		switch result {
		case .success(let characters):
			self.getImages {
				DispatchQueue.main.async {
					print("initPageController...")
					self.initPages()
				}
			}
		case .failure(let error):
			print("PANIC: charactersCompletion -> \(error)")
		}
	}
	
	//MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		dataSource = self
		delegate = self
		Task.init {
			do {
				print("awaiting Characters...")
				await requestCharacters(completion: charactersCompletion!)
			}
		}
	}
	
	//MARK: requestCharacters
	private func requestCharacters(completion: @escaping (Result<[Character], Error>) -> Void) async {
		
		let urlString = "https://akabab.github.io/starwars-api/api/all.json"
		
		AF.request(urlString).responseDecodable(of: [Character].self) { response in
			switch response.result {
			case .success(let characters):
				print("requestCharacters is SUCCESS")
				for i in 0...5 {
					self.receivedCharacters.append(characters[i])
				}
				completion(.success(self.receivedCharacters))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	//MARK: getImages
	private func getImages(completion: @escaping () -> Void) {
		
		let dispatchGroup = DispatchGroup()
		
		for var character in receivedCharacters {
			dispatchGroup.enter()
			AF.request(character.imageUrl).responseData { response in
				defer { dispatchGroup.leave() }
				switch response.result {
				case .success(let data):
					character.image = UIImage(data: data)
				case .failure(let error):
					print("PANIC: getImages AF .failure -> \(error)")
				}
			}
		}
		dispatchGroup.notify(queue: .main) {
			completion()
		}
	}
	
	//MARK: initPages
	private func initPages() {
		
		for character in receivedCharacters {
			if let singlePage = storyboard?.instantiateViewController(identifier: "ContentViewControllerID") as? PageViewController {
				singlePage.character = character
				pages.append(singlePage)
				
			}
		}
		self.pageControl.numberOfPages = pages.count
		if let firstPage = pages.first {
			setViewControllers([firstPage], direction: .forward, animated: true)
		}
		pageControl.currentPageIndicatorTintColor = .red
		pageControl.pageIndicatorTintColor = UIColor(named: "SwYellow")
		didMove(toParent: self)
		print("InitPages Completed")
	}
}


//MARK: DataSource, Delegate
extension PageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		
		guard let thisPage = viewController as? PageViewController else { return nil }
		guard let currentIndex = pages.firstIndex(of: thisPage) else { return nil }
		
		if currentIndex == 0 {
			return pages.last
		} else {
			return pages[currentIndex - 1]
		}
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		guard let thisPage = viewController as? PageViewController else { return nil }
		guard let currentIndex = pages.firstIndex(of: thisPage) else { return nil }
		
		if currentIndex == pages.count - 1 {
			return pages.first
		} else {
			return pages[currentIndex + 1]
		}
	}
	
	//MARK: Optional from Delegate
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		
		guard let viewControllers = pageViewController.viewControllers else { return }
		guard let currentIndex = pages.firstIndex(of: viewControllers[0] as! PageViewController) else { return }
		
		pageControl.currentPage = currentIndex
	}
}
