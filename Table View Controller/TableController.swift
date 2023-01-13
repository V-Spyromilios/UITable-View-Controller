//
//  TableControllerTableViewController.swift
//  Table View Controller
//
//  Created by Evangelos Spyromilios on 13.01.23.
//

import UIKit

class TableController: UITableViewController {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		self.navigationItem.leftBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		
		return countries[section].count
		
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
		var cellDefaultConfiguration = cell.defaultContentConfiguration()
		
		cellDefaultConfiguration.text = countries[indexPath.section][indexPath.row].name
		cellDefaultConfiguration.secondaryText = countries[indexPath.section][indexPath.row].description
		cellDefaultConfiguration.image = UIImage(named: countries[indexPath.section][indexPath.row].flag ?? "")
		cellDefaultConfiguration.imageProperties.maximumSize = CGSize(width: 50, height: 50)
		cell.contentConfiguration = cellDefaultConfiguration //update cell's content Config. !!!
		
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
