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
    
    let clubs : [String] = ["Pitching Wedge", "9 Iron", "8 Iron","7 Iron","6 Iron","5 Iron"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        // Do any additional setup after loading the view.
        print("Hi clubs")
        print(clubs.count)
        
        if !UserDefaults().bool(forKey: "setup") {
            setUpDefaults(clubs)
            UserDefaults().set(true, forKey: "setup")
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath)
        cell.textLabel?.text = clubs[indexPath.row]
        cell.backgroundColor = .link
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController
        print(clubs[indexPath.row])
        clubVC.title = "\(clubs[indexPath.row]) Distance"
        navigationController?.pushViewController(clubVC, animated: true)
        print("Current club was \(currentClub)")
        currentClub = clubs[indexPath.row]
        print("Current club is now \(currentClub)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("returning this many \(clubs.count)")
        return clubs.count
    }
    
    
    
    


}

