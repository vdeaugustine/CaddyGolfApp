//
//  EditClubDistanceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/4/21.
//

import UIKit

class EditClubDistanceViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var currentDistanceLabel: UILabel!
    @IBOutlet var avgDistance: UILabel!

    @IBOutlet var swingTypeSegControl: UISegmentedControl!
    @IBOutlet var prevHitsTableView: UITableView!
    /// The text field that will receive the yardage from the user for this club
    @IBOutlet var clubTextField: UITextField!
    var swingTypeSelected : swingTypes = .threeFourths
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTextField.placeholder = "Change 3/4 Distance for Club"
        clubTextField.delegate = self
        // Add the save button to the top right part of the nav controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveClub))
        prevHitsTableView.delegate = self
        prevHitsTableView.dataSource = self
//        removeEmptyFromPrevHits()

        prevHitsTableView.reloadData()
    }

    /// Will be used to save the club if the return button is hit on the text field keyboard
    // As of right now, the text field doesn't have a return button as it is only a number pad, so this bit of code is not useful
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveClub()
        textField.resignFirstResponder()
        return true
    }

    /// Function that will be called when the user hits save button at top of screen.
    /// Function will add the newly updated user bag to the UserDefaults, and update global mainBag variable
    @objc func saveClub() {
        // Make sure that the info entered into the text field is appropriate
        guard let enteredDistance = clubTextField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return
        }

        let distAsInt = Int("\(enteredDistance)")! // The value that will be saved to ClubObject as distance
        // Send an alert to the user if they put in a ridiculous yardage amount
        if distAsInt > 450 {
            let alert = UIAlertController(title: "\(distAsInt)? Really?", message: "Come on, let's be realistic lol", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")

                case .cancel:
                    print("cancel")

                case .destructive:
                    print("destructive")

                @unknown default:
                    print("whateverIDC")
                }
            }))
            present(alert, animated: true, completion: nil)
        }

        /// This will be used to figure out which type of club it is, so we can find which sub-array it belongs to
        var typeOfClubChosen: clubTypesEnum
        switch currentClubCORE.type {
        case "Wood":
            typeOfClubChosen = .woods
        case "Iron":
            typeOfClubChosen = .irons
        case "Hybrid":
            typeOfClubChosen = .hybrids
        case "Wedge":
            typeOfClubChosen = .wedges
        default:
            print("Problem with currentClub.type switch in EditClubDistanceViewController")

            // MARK: - Core Data Save

            updateClub(club: currentClubCORE, newAverage: distAsInt, averageType: swingTypeSelected)
//        createItem(name: currentClub.name, typeOfClub: distAsInt)

            // Once we call it, let's dismiss this View controller
        navigationController?.popViewController(animated: true)
            
        }
    }

    @IBAction func swingTypeSegControlChange(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        switch swingTypeSegControl.selectedSegmentIndex {
        case 0:
            currentDistanceLabel.text = "Current 3/4 Distance: \(currentClubCORE.threeFourthsDistance)"
            clubTextField.placeholder = "Change 3/4 Distance for Club"
            swingTypeSelected = .threeFourths
        case 1:
            currentDistanceLabel.text = "Current Full Distance: \(currentClubCORE.fullSwingDistance)"
            clubTextField.placeholder = "Change Full Distance for Club"
            swingTypeSelected = .full
        case 2:
            currentDistanceLabel.text = "Current Max Distance: \(currentClubCORE.maxDistance)"
            clubTextField.placeholder = "Change Max Distance for Club"
            swingTypeSelected = .max
        default:
            print()
        }
    }
}

extension EditClubDistanceViewController: UITableViewDelegate, UITableViewDataSource {
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNew")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "prevHit")!
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // 1. Create the alert controller.
            let alert = UIAlertController(title: "Enter Distance", message: "Of Previous Shot", preferredStyle: .alert)

            // 2. Add the text field. You can configure it however you need.
            alert.addTextField { textField in
                textField.placeholder = "Yardage"
                textField.keyboardType = .numberPad
            }

            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                if let theDistance = textField?.text, theDistance.isInt {
                    
                }

                print("Text field: \(textField?.text ?? "")")
                tableView.reloadData()

            }))

            // 4. Present the alert.
            present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }
}
