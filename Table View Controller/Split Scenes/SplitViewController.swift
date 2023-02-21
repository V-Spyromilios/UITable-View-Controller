//
//  SplitViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class SplitViewController: UISplitViewController {
	
	var country: CountryModel? {
		didSet {
			let detailView = self.viewControllers.last as? SplitDetailController
			detailView?.country = country
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.presentsWithGesture = true
		self.preferredDisplayMode = .oneBesideSecondary
		preferredSplitBehavior = .tile
		if self.displayMode == .secondaryOnly {
			show(.primary)
		}
	}
}

extension SplitViewController: SplitMasterDetailDelegate {
	
	func didSelectCountry(country: CountryModel) {
		let secondaryViewController = SplitDetailController()
		secondaryViewController.country = country
	}
}