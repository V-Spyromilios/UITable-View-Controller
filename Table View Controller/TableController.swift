//
//  TableControllerTableViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//
/// Array to be presented in TableView.
/// Each row to DetailView -> Modal like here
/// DetailView to show full text of  TableView row
/// Row with Image, title and description


import UIKit

class TableController: UITableViewController { // or ViewController and extend with the necessary functions
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return countries[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let country = countries[indexPath.section][indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
		var cellDefaultConfiguration = cell.defaultContentConfiguration()
		
		cellDefaultConfiguration.text = country.name.uppercased()
		cellDefaultConfiguration.textProperties.numberOfLines = 1
		
		cellDefaultConfiguration.secondaryTextProperties.numberOfLines = 1
		cellDefaultConfiguration.secondaryTextProperties.lineBreakMode = .byTruncatingTail
		cellDefaultConfiguration.secondaryTextProperties.color = .lightGray
		cellDefaultConfiguration.secondaryText = country.description
		
		cellDefaultConfiguration.image = UIImage(named: countries[indexPath.section][indexPath.row].flag ?? "")
		cellDefaultConfiguration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
		cell.contentConfiguration = cellDefaultConfiguration //update cell's content Config. !!!
		
//		if indexPath.row % 2 == 1 {
//			cell.backgroundColor = .green
//		} else {
//			cell.backgroundColor = .clear
//		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			return "EU"
		}
		else if section == 1 {
			return "LATIN AMERICA"
		}
		else { return nil }
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//		let country = countries[indexPath.section][indexPath.row]
		performSegue(withIdentifier: "seguetoDetailView", sender: self) // self = the tableView. (who performed segue). could be nil
	}
	
	
	//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	//		let country = countries[indexPath.row]
	//		performSegue(withIdentifier: "seguetoDetaillView", sender: country)
	//	}
	
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
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let indexPath = tableView.indexPathForSelectedRow {
			let selectedRow = indexPath.row
			guard let destinationViewController = segue.destination as? DetailViewController else { return }
			destinationViewController.countryData = countries[indexPath.section][selectedRow]
		}
	}
}
