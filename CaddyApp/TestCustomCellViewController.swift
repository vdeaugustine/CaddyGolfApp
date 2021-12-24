//
//  TestCustomCellViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/23/21.
//

import UIKit

class TestCustomCellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    @IBOutlet var clubsTableView: UITableView!
    let userBagCore = AppDelegate.userGolfBag

    override func viewDidLoad() {
        super.viewDidLoad()
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        makeGolfBagStandard()
        
        let nib = UINib(nibName: "BigClubCell", bundle: nil)
        clubsTableView.register(ClubTableViewCell.nib(), forCellReuseIdentifier: ClubTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainArr = AppDelegate.userGolfBag.allClubs2DArr else {
            return 0
        }
        return mainArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BigClubCell", for: indexPath) as! ClubTableViewCell
        
        
        guard let currentClubForCell = AppDelegate.userGolfBag.allClubs2DArr?[indexPath.section][indexPath.row] else {
            // This might give problem of returning a cell even if we don't want one. Look here if you are getting one too many cells
            return cell
        }
        let currentClubNameForCell = currentClubForCell.name
        cell.nameLabel.text = currentClubNameForCell!
        cell.tfLabel.text = "\(currentClubForCell.threeFourthsDistance)"
        cell.fullLabel.text = "\(currentClubForCell.fullSwingDistance)"
        cell.maxLabel.text = "\(currentClubForCell.maxDistance)"

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return userBagCore.clubTypes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }

}
