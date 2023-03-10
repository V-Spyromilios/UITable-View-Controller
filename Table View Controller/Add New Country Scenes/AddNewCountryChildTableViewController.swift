//
//  AddNewCountryChildTableViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 18.01.23.
//

import UIKit
import PhotosUI

class AddNewCountryChildTableViewController: UITableViewController, PHPickerViewControllerDelegate {
	
	@IBOutlet weak var countryNameField: UITextField!
	@IBOutlet weak var countryDescriptionField: UITextField!
	
	@IBOutlet weak var isEuMemberSwitch: UISwitch!
	@IBOutlet weak var imageView: UIImageView! {
		didSet {
			imageView.isUserInteractionEnabled = true
		}
	}
	@IBOutlet weak var countryGdpField: UITextField!

	
	override func viewDidLoad() {
		super.viewDidLoad()

		//MARK: - Add Gesture Rec. to Image for PHPicker
		let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(choosePhoto))
		imageView.addGestureRecognizer(tapRecogniser)
		
		let parent = self.parent as? AddNewCountryParentViewController
		parent?.OkButton.isEnabled = false
		[countryNameField, countryDescriptionField, countryGdpField].forEach({
			$0?.addTarget(self, action: #selector(changeButtonStatus), for: .editingChanged)
		})
	}
	
	//MARK: - Change Button visibility
	@objc func changeButtonStatus() {
		let parentViewController = self.parent as? AddNewCountryParentViewController
		if countryNameField.text?.count ?? "".count < 5 || countryDescriptionField.text?.count ?? "".count < 5 || countryGdpField.text?.count ?? "".count < 5 {
			return
		}
		parentViewController?.OkButton.isEnabled = true
	}
	
	@objc func choosePhoto() {
		openPHPicker()
	}
	
	// MARK: - Save Country with UnwindAction
	@IBAction func UnwindAction(unwindSegue: UIStoryboardSegue) {
		let parentController = self.parent as? AddNewCountryParentViewController
		parentController?.newCountry.name = countryNameField.text ?? ""
		parentController?.newCountry.description = countryDescriptionField.text ?? ""
		parentController?.newCountry.euMember = isEuMemberSwitch.isOn
		parentController?.newCountry.flag = imageView.image
		parentController?.newCountry.gdp = Int(countryGdpField.text ?? "")
		
		if parentController?.newCountry.euMember == true {
			sortedCountries[0].append(parentController!.newCountry)
			sortedCountries = sortCountries(for: 0)
		} else {
			sortedCountries[1].append(parentController!.newCountry)
			sortedCountries = sortCountries(for: 1)
		}
		dismiss(animated: true)
	}
	
	//MARK: - PHPicker functions
	private func openPHPicker() {
		var configuration = PHPickerConfiguration()
		configuration.selectionLimit = 1
		configuration.filter = .images
		
		let pickerViewController = PHPickerViewController(configuration: configuration)
		pickerViewController.delegate = self
		self.present(pickerViewController, animated: true, completion: nil)
	}
	
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		picker.dismiss(animated: true, completion: nil)
		
		for result in results {
			result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
				if let image = object as? UIImage {
					DispatchQueue.main.async {
							self.imageView.image = image
					}
				}
			})
		}
	}
}
