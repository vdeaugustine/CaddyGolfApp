//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit

var currentClub: String = "NANA"

class ClubsViewController: UIViewController {
    @IBOutlet var clubsTableView: UITableView!
    var userBag = defaultBag()
    override func viewDidLoad() {
        super.viewDidLoad()

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
            print("\nOK is SETUP. LETS TRY this\n")
            do {
                let getUserBag = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
                print(getUserBag)
                userBag = getUserBag
            } catch {
                print(error.localizedDescription)
            }

            // This is the example **************************************************
            //            do {
            //                let playingItMyWay = try userDefaults.getCustomObject(forKey: "MyFavouriteBook", castTo: Book.self)
            //                print(playingItMyWay)
            //            } catch {
            //                print(error.localizedDescription)
            //            }

            // This is the example **************************************************
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addClub))
        // self.action(sender:)
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
        currentClub = clubName
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
