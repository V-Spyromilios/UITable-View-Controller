//
//  PopUpViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 01.02.23.
//

import UIKit

class PopUpViewController: UIViewController {
	
	var countryData: CountryModel?
	
	@IBOutlet weak var countryNameLabel: UILabel!
	
	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet weak var imageView: UIImageView!
	
	@IBOutlet weak var gdpLabel: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		containerView.layer.shadowColor = UIColor.gray.cgColor
		containerView.layer.shadowOpacity = 0.9
		containerView.layer.shadowRadius = 10
		containerView.backgroundColor = .white
		containerView.layer.cornerRadius = 8
		
		let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissView))
		let swipeRecogniser = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
		view.addGestureRecognizer(tapRecogniser)
		view.addGestureRecognizer(swipeRecogniser)
		view.backgroundColor = .clear
		
		imageView.image = countryData?.flagName
		imageView.layer.cornerRadius = imageView.frame.height / 2
		imageView.layer.shadowColor = UIColor.black.cgColor
		imageView.layer.shadowOpacity = 0.9
		imageView.layer.shadowRadius = 10
		imageView.layer.borderWidth = 1
		imageView.layer.borderColor = UIColor.gray.cgColor
		
		imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
		
		countryNameLabel.text = countryData?.name
		countryNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
		
		gdpLabel.text = "GDP:\n \(countryData!.gdp!)"
		gdpLabel.font = UIFont(name: "Gill Sans Light", size: 22)
	}
	
	@objc func dismissView() {
		self.dismiss(animated: true)
	}
}
