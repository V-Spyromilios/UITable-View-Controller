//
//  ViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var countryNameLabel: UILabel!
	
	@IBOutlet weak var countryFlagImage: UIImageView!
	
	@IBOutlet weak var countryDescriptionTextView: UITextView!

	@IBSegueAction func segueToDetailView(_ coder: NSCoder) -> ViewController? {
		return <#ViewController(coder: coder)#>
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

