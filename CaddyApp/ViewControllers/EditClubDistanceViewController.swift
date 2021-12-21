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
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTextField.placeholder = "Change 3/4 Distance for Club"
        clubTextField.delegate = self
        avgDistance.text = "Average Distance: \(currentClub.averageDistance)"
        currentDistanceLabel.text = " Current Distance: \(currentClub.fullDistance)"
        // Add the save button to the top right part of the nav controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveClub))
        prevHitsTableView.delegate = self
        prevHitsTableView.dataSource = self
        removeEmptyFromPrevHits()
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

        // Need to get userBag so we can edit it
        let userDefaults = UserDefaults.standard
        do {
            let userBagReturned = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            mainBag = userBagReturned
        } catch {
            print(error.localizedDescription)
        }

        print(type(of: mainBag))
//        print("GOT USER BAG")
        /// This will be used to figure out which type of club it is, so we can find which sub-array it belongs to
        var typeOfClubIndex: Int = 0

        switch currentClub.type {
        case "Wood":
            typeOfClubIndex = 0
        case "Iron":
            typeOfClubIndex = 1
        case "Hybrid":
            typeOfClubIndex = 2
        case "Wedge":
            typeOfClubIndex = 3
        default:
            print("Problem with currentClub.type switch in EditClubDistanceViewController")
            // The below code should be a less clean version of the above code. If we run and it doesn't have a problem, this can be deleted
//            if currentClub.type == "Wood" {
//                typeOfClubIndex = 0
//            } else if currentClub.type == "Iron" {
//                typeOfClubIndex = 1
//            } else if currentClub.type == "Hybrid" {
//                typeOfClubIndex = 2
//            } else if currentClub.type == "Wedge" {
//                typeOfClubIndex = 3
//            } else {
//                print("\nERROR ERROR. CLUB TYPE NOT FOUND")
//            }
        }

        // Go through the subindex of 2DArray (index of club type we are looking for) and find the index for the club itself
        var indexOfClub = 0
        for i in 0 ..< mainBag.allClubs2DArray[typeOfClubIndex].count {
            print("\nIS \(currentClub) == \(mainBag.allClubs2DArray[i])? -- ")
            if currentClub == mainBag.allClubs2DArray[typeOfClubIndex][i] {
                print("YES")
                indexOfClub = i
            } else {
                print("NO!!")
            }
        }
        let newClub = ClubObject(name: currentClub.name, type: currentClub.type, fullDistance: distAsInt, threeFourthsDistance: Int(Double(distAsInt) * 0.75), maxDistance: Int(Double(distAsInt) * 1.25), averageDistance: 0, previousHits: "")
        mainBag.allClubs2DArray[typeOfClubIndex][indexOfClub] = newClub

        // Save the bag to the defaults
        doSave(userDefaults: userDefaults, saveThisBag: mainBag)

        // MARK: - Core Data Save

//        createItem(name: currentClub.name, typeOfClub: distAsInt)

        // Once we call it, let's dismiss this View controller
//        navigationController?.popViewController(animated: true)
        let tempViewController = storyboard?.instantiateViewController(identifier: "TestTableViewController") as! TestTableViewController
        navigationController?.pushViewController(tempViewController, animated: true)
    }

    @IBAction func swingTypeSegControlChange(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        switch swingTypeSegControl.selectedSegmentIndex {
        case 0:
            currentDistanceLabel.text = "Current 3/4 Distance: \(currentClub.threeFourthsDistance)"
            clubTextField.placeholder = "Change 3/4 Distance for Club"
        case 1:
            currentDistanceLabel.text = "Current Full Distance: \(currentClub.fullDistance)"
            clubTextField.placeholder = "Change Full Distance for Club"
        case 2:
            currentDistanceLabel.text = "Current Max Distance: \(currentClub.maxDistance)"
            clubTextField.placeholder = "Change Max Distance for Club"
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
        var arrOfPrevHits = currentClub.previousHits.components(separatedBy: ",")
        if arrOfPrevHits.last == "" {
            _ = arrOfPrevHits.popLast()
        }

        if arrOfPrevHits.count > 0 {
            print(arrOfPrevHits)
            print("")
            return arrOfPrevHits.count + 1
        } else {
            print(arrOfPrevHits)
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNew")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "prevHit")!
            let arrOfPrevHits = currentClub.previousHits.components(separatedBy: ",")
            cell.textLabel?.text = arrOfPrevHits[indexPath.row - 1]
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
                    currentClub.previousHits.append("\(theDistance),")
                    currentClub.averageDistance = getAvgFromStr(currentClub.previousHits)
                    saveCurrentClub()
                }

                print("Text field: \(textField?.text ?? "")")
                tableView.reloadData()
                self.avgDistance.text = "Average Distance: \(currentClub.averageDistance)"

            }))

            // 4. Present the alert.
            present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromCurrentClubPrevHits(thisIndex: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
        avgDistance.text = "Average Distance: \(currentClub.averageDistance)"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }
}
