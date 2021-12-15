//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit

var currentClub: ClubObject = ClubObject(name: "Driver", type: "Wood", distance: 275)

class ClubsViewController: UIViewController {
    @IBOutlet var clubsTableView: UITableView!
    var userBag = defaultBag()

//    override func viewDidLayoutSubviews() {
////        print("Called layoutsubviews")
////        clubsTableView.reloadData()
//    }

    override func viewDidAppear(_ animated: Bool) {
//        print("called viewdidappear")

//        print("\n\n\n\n\nDOING THIS IN VIEWDIDAPPEAR\n\n\n\n\n")

        do {
            let getUserBag = try UserDefaults.standard.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            userBag = getUserBag
        } catch {
            print(error.localizedDescription)
        }
        clubsTableView.reloadData()
    }

    override func viewDidLoad() {
//        print("\n\n\n\n\ncalled viewdidload\n\n\n\n\n")
        super.viewDidLoad()
//        clubsTableView.reloadData()
//        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        let userDefaults = UserDefaults.standard

        // If user has not been set up before
        if !userDefaults.bool(forKey: "setup") {
            print("\nOK NOT SETUP. LETS TRY\n")
            userDefaults.set(true, forKey: "setup")
//            do {
//                try userDefaults.setCustomObject(userBag, forKey: "user_bag")
//            } catch {
//                print(error.localizedDescription)
//            }
            doSave(userDefaults: userDefaults, saveThisBag: userBag)

        } else {
//            print("\n\n\n\n\nOK is SETUP. LETS TRY this\n\n\n\n\n")
            do {
                let getUserBag = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
                userBag = getUserBag
            } catch {
                print(error.localizedDescription)
            }
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
    }

    @objc func addClub() {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
        let currentClubNameForCell = userBag.arrayOfArrays[indexPath.section][indexPath.row].name
        let currentClubDistance = userBag.arrayOfArrays[indexPath.section][indexPath.row].distance
        cell.textLabel?.text = currentClubNameForCell
        cell.yardsLabel.text = "\(currentClubDistance)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController
        let clubName = userBag.arrayOfArrays[indexPath.section][indexPath.row].name
        clubVC.title = "\(clubName) Distance"
        navigationController?.pushViewController(clubVC, animated: true)
        currentClub = userBag.arrayOfArrays[indexPath.section][indexPath.row]
        let taptic = UIImpactFeedbackGenerator(style: .rigid)
        taptic.impactOccurred(intensity: 1.0)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userBag.arrayOfArrays[indexPath.section].remove(at: indexPath.row)
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
