//
//  TestViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 23.01.23.
//

import UIKit

class TestViewController: UIViewController {

	
	@IBOutlet weak var table: UITableView!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "customCellIdentifier", for: indexPath) as! CustomCell
		let country = countries[indexPath.section][indexPath.row]
		cell.updateCustomCell(with: country)
		cell.showsReorderControl = true

		return cell
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
