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
    @IBOutlet var metersSwitch: UISwitch!
    @IBOutlet var swingTypeSwitch: UISwitch!

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
    }
}
