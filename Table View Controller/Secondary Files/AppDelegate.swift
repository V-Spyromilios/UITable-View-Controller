//
//  AppDelegate.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
//	func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
//		
//		
//	}
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		
		let isEnabled = UserDefaults.standard.value(forKey: "CountriesAreInitialised") as? Bool
		if isEnabled != true {

			FileAssistant.shared.createFlagsDirectories()
			initCoreData(context: CoreDataAssistant.context)
//			FileAssistant.shared.loadFlagPaths()
		}
		else {
//			let uDFlagsUrl = FileAssistant.shared.userDefaults.url(forKey: "storedFlagsDirectory")
//			print("\(String(describing: uDFlagsUrl))")
			FileAssistant.shared.loadFlagPaths()
		}

		return true
	}


	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}
	
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

	}
	
	func applicationWillTerminate(_ application: UIApplication) {

		CoreDataAssistant.saveContext()
	}

}
