//
//  tabBarController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 07.02.23.
//

import UIKit

class tabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		setUpItems()
		setUpTabBar()
    }

	func setUpTabBar() {
		tabBar.tintColor = .yellow
		tabBar.backgroundColor = .opaqueSeparator
	}

	func setUpItems() {

		tabBar.items?[0].image = UIImage(systemName: "globe.europe.africa.fill")
		tabBar.items?[0].image?.withTintColor(.yellow)
		tabBar.items?[1].image = UIImage(systemName: "dollarsign.circle")
		tabBar.items?[1].image?.withTintColor(.yellow)
//		tabBar.items?[2].image = UIImage(systemName: "carbon.dioxide.cloud.fill")

	}

	
}
