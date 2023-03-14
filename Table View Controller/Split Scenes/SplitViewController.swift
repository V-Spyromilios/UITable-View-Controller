//
//  SplitViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit
import CoreData


class SplitViewController: UISplitViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.presentsWithGesture = true
		self.preferredDisplayMode = .oneBesideSecondary

		self.delegate = self.viewControllers.first?.children.first as? SplitMasterViewController
	}
}
