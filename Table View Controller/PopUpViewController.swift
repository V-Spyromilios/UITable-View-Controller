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
	
	override func viewDidLoad() {
        super.viewDidLoad()

//		containerView.layer.cornerRadius = containerView.frame.height / 2
		containerView.backgroundColor = UIColor.gray
//		containerView.layer.shadowColor = UIColor.black.cgColor
//		containerView.layer.shadowOffset = CGSize(width: 20, height: 200)
//		view.backgroundColor  = .clear
//		let blurEffect = UIBlurEffect(style: .light)
//		let blurView = UIVisualEffectView(effect: blurEffect)
//		blurView.translatesAutoresizingMaskIntoConstraints = true
//		view.insertSubview(blurView, at: 0)

		countryNameLabel.text = countryData?.name
		countryNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)

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
