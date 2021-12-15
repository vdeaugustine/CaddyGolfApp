//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit

var currentClub: ClubObject = ClubObject(name: "Driver", type: "Wood", distance: 275)
var mainBag: UserBag = defaultBag()

class ClubsViewController: UIViewController {
    @IBOutlet var clubsTableView: UITableView!
    var userBag : UserBag
    
    required init?(coder aDecoder: NSCoder) {
        self.userBag = defaultBag()
        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clubsTableView.reloadData()
        print("\n\n\n\n\nDOING THIS IN VIEWDIDAPPEAR\n\n\n\n\n")

        do {
            let getUserBag = try UserDefaults.standard.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            print("immediately after")
            userBag = getUserBag
            printBagOutLines(bag: userBag)
            mainBag = getUserBag
        } catch {
            print(error.localizedDescription)
        }
        sortBag(bag: &userBag)
        
    }

    override func viewDidLoad() {
        print("\n\n\n\n\ncalled viewdidload\n\n\n\n\n")
        super.viewDidLoad()
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        let userDefaults = UserDefaults.standard

        // If user has not been set up before
        if !userDefaults.bool(forKey: "setup") {
            print("\nOK NOT SETUP. LETS TRY\n")
            userDefaults.set(true, forKey: "setup")
            doSave(userDefaults: userDefaults, saveThisBag: userBag)

        } else {
            print("\n\n\n\n\nOK is SETUP. LETS TRY this\n\n\n\n\n")
            do {
                let getUserBag = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
                print("Getusrbg")
                printBagOutLines(bag: getUserBag)
                userBag = getUserBag
                mainBag = getUserBag
            } catch {
                print(error.localizedDescription)
            }
        }
        print("userBag")
        printBagOutLines(bag: userBag)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
    }

    @objc func resetAllClubDistances() {
        setUpDefaults()
        checkDefaults(clubsArray: clubs)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Calling CELLFORROWAT")
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
//        let currentClubForCell = userBag.arrayOfArrays[indexPath.section][indexPath.row]
//        let currentClubNameForCell = currentClubForCell.name
//        let currentClubDistance = currentClubForCell.distance
        let currentClubForCell = mainBag.arrayOfArrays[indexPath.section][indexPath.row]
        let currentClubNameForCell = currentClubForCell.name
        let currentClubDistance = currentClubForCell.distance
        print("TABLE---", currentClubForCell)
        cell.textLabel?.text = currentClubNameForCell
        cell.yardsLabel.text = "\(currentClubDistance)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController
//        let clubName = userBag.arrayOfArrays[indexPath.section][indexPath.row].name
        let clubName = mainBag.arrayOfArrays[indexPath.section][indexPath.row].name
        clubVC.title = "\(clubName) Distance"
        navigationController?.pushViewController(clubVC, animated: true)
//        currentClub = userBag.arrayOfArrays[indexPath.section][indexPath.row]
        currentClub = mainBag.arrayOfArrays[indexPath.section][indexPath.row]
        let taptic = UIImpactFeedbackGenerator(style: .rigid)
        taptic.impactOccurred(intensity: 1.0)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            userBag.arrayOfArrays[indexPath.section].remove(at: indexPath.row)
            mainBag.arrayOfArrays[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Make sure you save the updated bag to defaults so the delete is perminent
            doSave(userDefaults: UserDefaults.standard, saveThisBag: userBag)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBag.arrayOfArrays[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return userBag.types.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userBag.types[section]
    }
}
