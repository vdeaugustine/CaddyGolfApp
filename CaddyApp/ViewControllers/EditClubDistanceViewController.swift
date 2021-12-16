//
//  EditClubDistanceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/4/21.
//

import UIKit

class EditClubDistanceViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var currentDistanceLabel: UILabel!

    /// The text field that will receive the yardage from the user for this club
    @IBOutlet var clubTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTextField.delegate = self

        // Add the save button to the top right part of the nav controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveClub))
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

        print("Setting \(enteredDistance) as distance for \(currentClub)")

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
        if currentClub.type == "Wood" {
            typeOfClubIndex = 0
        } else if currentClub.type == "Iron" {
            typeOfClubIndex = 1
        } else if currentClub.type == "Hybrid" {
            typeOfClubIndex = 2
        } else if currentClub.type == "Wedge" {
//                typeOfClubIndex = 3
        } else {
            print("\nERROR ERROR. CLUB TYPE NOT FOUND")
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
        let newClub = ClubObject(name: currentClub.name, type: currentClub.type, distance: distAsInt)
        mainBag.allClubs2DArray[typeOfClubIndex][indexOfClub] = newClub

        // Save the bag to the defaults
        doSave(userDefaults: userDefaults, saveThisBag: mainBag)

        // Once we call it, let's dismiss this View controller
        navigationController?.popViewController(animated: true)
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
