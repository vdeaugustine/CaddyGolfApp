//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit

/// This is the main ViewController. Where user will be changing and viewing bag
class ClubsViewController: UIViewController {
    
    
    @IBOutlet var clubsTableView: UITableView!
    

    @IBOutlet var swingTypeToggle: UIButton!

    var currentSwingTypeState = swingTypeState.threeFourths
    
    override func viewWillAppear(_ animated: Bool) {
        self.clubsTableView.delaysContentTouches = false
        clubsTableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
    }

    override func viewDidAppear(_ animated: Bool) {
        
        self.clubsTableView.insetsContentViewsToSafeArea = true
        clubsTableView.cellLayoutMarginsFollowReadableWidth = true
        
        
        // When the clubs view is loaded, it should update mainBag with whatever is in the userDefaults
        // ... although, this might be moved to viewDidLoad() or some other function at a later time. If the mainBag is a global variable that can be edited in other viewControllers, then we might not have to call from UserDefaults, because the mainBag will have already been updated
        do {
            let getUserBag = try UserDefaults.standard.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            print("immediately after")
            mainBag = getUserBag
        } catch {
            print(error.localizedDescription)
        }
        sortBag()
        clubsTableView.reloadData()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModalTransitionMediator.instance.setListener(listener: self)

        
        
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        clubsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let userDefaults = UserDefaults.standard

        // If there is nothing saved in the UserDefaults (i.e. the first time opening this app)
        if !userDefaults.bool(forKey: "setup") {
            print("\nOK NOT SETUP. LETS TRY\n")
            userDefaults.set(true, forKey: "setup")
            doSave(userDefaults: userDefaults, saveThisBag: mainBag)

        } else {
            do {
                let getUserBag = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
                mainBag = getUserBag
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    /// This will make all of the clubs in the User's bag back to default distances.
    // will need to be updated at a later time
    @objc func resetAllClubDistances() {
        let alert = UIAlertController(title: "Reset all clubs", message: "Are you sure you would like to reset your bag to default?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("yes default")
                mainBag = defaultBag()
                doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
                self.clubsTableView.reloadData()
            case .cancel:
                print("yes cancel")

            case .destructive:
                print("yes destructive")

            @unknown default:
                print("whateverIDC")
            }
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            switch action.style {
            case .default:
                print("cancel default")

            case .cancel:
                print("cancel cancel")

            case .destructive:
                print("cancel destructive")

            @unknown default:
                print("whateverIDC")
            }
        }))
        present(alert, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    @IBAction func swingTypeToggleTapped(_ sender: UIButton) {
        switch currentSwingTypeState {
        case .fullSwing:
            print("FULLSWING")
            currentSwingTypeState = .maxSwing
            swingTypeToggle.setTitle("MAX", for: .normal)
        case .maxSwing:
            print("MAXSWING")
            currentSwingTypeState = .threeFourths
            swingTypeToggle.setTitle("3/4", for: .normal)
        case .threeFourths:
            print("TFSWING")
            currentSwingTypeState = .fullSwing
            swingTypeToggle.setTitle("FULL", for: .normal)
        }
        clubsTableView.reloadData()
    }
}

// MARK: - TABLE VIEW STUFF

extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Making Table View Cell

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
        let currentClubForCell = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
        let currentClubNameForCell = currentClubForCell.name.uppercased()
        cell.clubNameLabel.text = currentClubNameForCell
        cell.yardsBox.setMainText("\(currentClubForCell.fullDistance)")
        cell.yardsBox.setHeaderText("Full Swing")
        cell.notesBox.setHeaderText("Notes")
        cell.notesBox.setMainText(currentClubForCell.mostRecentClubNoteTitle)
        cell.yardsBox.layoutViews()
        cell.notesBox.layoutViews()
        
//        cell.textLabel?.text = currentClubNameForCell
        
//        cell.yardsLabel.text = {
//            switch currentSwingTypeState {
//            case .fullSwing:
//                return "\(currentClubForCell.fullDistance)"
//            case .threeFourths:
//                return "\(currentClubForCell.threeFourthsDistance)"
//            case .maxSwing:
//                return "\(currentClubForCell.maxDistance)"
//            }
//
//        }()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    

    // MARK: Row Selected

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(mainBag.allClubs2DArray[indexPath.section][indexPath.row]) selected")
        tableView.deselectRow(at: indexPath, animated: true)
        currentClub = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
        let taptic = UIImpactFeedbackGenerator(style: .rigid)
        taptic.impactOccurred(intensity: 1.0)

        // Create new view controller that will be used to edit club distance
        let clubVC = storyboard?.instantiateViewController(identifier: "sketchTest") as! MainClubViewController
        let clubName = mainBag.allClubs2DArray[indexPath.section][indexPath.row].name
        clubVC.title = "\(clubName)".capitalized

        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(clubVC, animated: true)
    }

    // MARK: Rest of Table View Stuff

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove it from the data model
            mainBag.allClubs2DArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Make sure you save the updated bag to defaults so the delete is perminent
            doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainBag.allClubs2DArray[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return mainBag.types.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainBag.types[section]
    }
}


extension ClubsViewController: ModalTransitionListener {
//other code
//required delegate func
func popoverDismissed() {
    self.navigationController?.dismiss(animated: true, completion: nil)
    sortBag()
    clubsTableView.reloadData()
}
}