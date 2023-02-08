//
//  SplitViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 08.02.23.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		var firstViewController = GdpTableController()
		var secondViewController = SplitSecondaryViewController()
		self.viewControllers = [firstViewController, secondViewController]
		self.preferredDisplayMode = .oneBesideSecondary
		

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
