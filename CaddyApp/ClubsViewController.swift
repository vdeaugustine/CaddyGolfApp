//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit

var currentClub :  String = "NANA"

class ClubsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var clubsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        // Do any additional setup after loading the view.
        print("Hi clubs")
        print(clubs.count)
        
        if !UserDefaults().bool(forKey: "setup") {
            setUpDefaults()
            checkDefaults(clubsArray: clubs)
            UserDefaults().set(true, forKey: "setup")
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addClub))
        //self.action(sender:)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
        let thisClub = "\(allClubsByType[indexPath.section][indexPath.row])"
        cell.textLabel?.text = thisClub
        if let yards = UserDefaults().value(forKey: thisClub) {
            cell.yardsLabel.text = "\(yards) yards"
        } else {
            cell.yardsLabel.text = "NOT SET"
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController
        let clubName = allClubsByType[indexPath.section][indexPath.row]
        clubVC.title = "\(clubName) Distance"
        navigationController?.pushViewController(clubVC, animated: true)
//        print("Current club was \(currentClub)")
        currentClub = clubName
//        print("Current club is now \(currentClub)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClubsByType[section].count
    }
    
    
    @objc func resetAllClubDistances() {
        setUpDefaults()
        checkDefaults(clubsArray: clubs)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return clubTypes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return clubTypes[section]
    }
    
    @objc func addClub () {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allClubsByType[indexPath.section].remove(at: indexPath.row)
//            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

