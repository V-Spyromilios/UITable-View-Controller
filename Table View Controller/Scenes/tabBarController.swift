//
//  tabBarController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 07.02.23.
//

import UIKit
import CoreData

class tabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setUpItems()
		setUpTabBar()
	}
	
	func setUpTabBar() {
		
		tabBar.tintColor = .orange
	}
	
	func setUpItems() {
		
		tabBar.items?[0].image = UIImage(systemName: "globe.europe.africa.fill")
//		tabBar.items?[0].badgeValue = String(())
		tabBar.items?[1].image = UIImage(systemName: "map.fill")
		//		tabBar.items?[2].image = UIImage(systemName: "carbon.dioxide.cloud.fill")
		
	}
}
