//
//  CrawlViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 21.03.23.
//

import UIKit

class CrawlViewController: UIViewController {

	
	@IBOutlet weak var crawlLabel: UILabel!
	var crawl: String?

	override func viewDidLoad() {
        super.viewDidLoad()

		setUpCrawlBackground()
		
		crawlLabel.text = crawl!
		crawlLabel.textColor = UIColor(named: "SwYellow")
		crawlLabel.adjustsFontSizeToFitWidth = true
		crawlLabel.font = UIFont(name: "Gotham", size: 40)
    }
    

	private func setUpCrawlBackground() {

		let backgroundImage = UIImageView(frame: self.view.bounds)
		backgroundImage.image = UIImage(named: "Andromeda_Galaxy")
		backgroundImage.contentMode = .scaleAspectFill
		backgroundImage.clipsToBounds = true
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(backgroundImage)
		self.view.sendSubviewToBack(backgroundImage)
	}

}
