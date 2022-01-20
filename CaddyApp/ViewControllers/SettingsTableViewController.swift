//
//  SettingsTableViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/11/22.
//

import UIKit

/// - List of settings to implement
///     - What type of swing you want to display by default
///     - If you want to see notes or other swing type on clubsviewcontroller
///     - Use manual yardage or average yardage from swings
class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var metersSwitch: UISwitch!
    @IBOutlet weak var swingTypeSwitch: UISwitch!
    

    @IBAction func metersChanged(_ sender: Any) {
        useMeters = metersSwitch.isOn
        let defaults = UserDefaults()
        defaults.setValue(useMeters, forKey: "useMeters")
        print(useMeters)
    }
    
    @IBAction func swingTypesChanged(_ sender: Any) {
        useSwingTypes = swingTypeSwitch.isOn
        let defaults = UserDefaults()
        defaults.setValue(useMeters, forKey: "useSwingTypes")
        print(useSwingTypes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.metersSwitch.isOn = useMeters
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Defaults"
        case 1:
            return "Feedback"
        default:
            return ""
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("was tapped at", indexPath)
//        if indexPath.row == 2 {
//            let vc = storyboard?.instantiateViewController(withIdentifier: "RulesTableViewController") as! RulesTableViewController
//            vc.title = "Rules and Information"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
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
