//
//  AddNewCountryChildTableViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 18.01.23.
//

import UIKit

class AddNewCountryChildTableViewController: UITableViewController {

	@IBOutlet weak var countryNameField: UITextField!
	@IBOutlet weak var countryDescriptionField: UITextField!
	
	@IBOutlet weak var isEuMemberSwitch: UISwitch!
	
	@IBOutlet weak var countryGdpField: UITextField!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		countryNameField.delegate = self
		countryDescriptionField.delegate = self
		
		
//		let parentController = self.parent as? AddNewCountryViewController
//		parentController?.newCountry?.name = countryNameField.text ?? ""
//		parentController?.newCountry?.description = countryDescriptionField.text ?? ""
//		parentController?.newCountry?.euMember = isEuMemberSwitch.isOn
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

	@IBAction func UnwindAction(unwindSegue: UIStoryboardSegue) {
		let parentController = self.parent as? AddNewCountryParentViewController
		parentController?.newCountry.name = countryNameField.text ?? ""
		parentController?.newCountry.description = countryDescriptionField.text ?? ""
		parentController?.newCountry.euMember = isEuMemberSwitch.isOn
		
		if parentController?.newCountry.name != nil {
			if ((parentController?.newCountry.euMember) != false) {
				countries[0].append((parentController?.newCountry)!)
			}
			else {
				countries[1].append((parentController?.newCountry)!)
			}
			dismiss(animated: true)
		}
	}

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewCountryChildTableViewController: UITextFieldDelegate {

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

		guard let oldCountryNameText = countryNameField.text,
			 let oldCountryDescriptionText = countryDescriptionField.text else { return false }

		let newCountryNameText = (oldCountryNameText as NSString).replacingCharacters(in: NSRangeFromString(string), with: string)
		let newCountryDescriptionText = (oldCountryDescriptionText as NSString).replacingCharacters(in: NSRangeFromString(string), with: string)

		(self.parent as? AddNewCountryParentViewController)?.OkButton.isEnabled = {
			if !newCountryNameText.isEmpty && !newCountryDescriptionText.isEmpty {
				return true
			}
			else { return false }
		}()
		return true
	}
}
