//
//  EditClubDistanceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/4/21.
//

import UIKit

class EditClubDistanceViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var currentDistanceLabel: UILabel!

    @IBOutlet var clubTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTextField.delegate = self
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveClub))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveClub()
        textField.resignFirstResponder()
        return true
    }

    @objc func saveClub() {
        guard let enteredDistance = clubTextField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return
        }

        let distAsInt = Int("\(enteredDistance)")!
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
            print(type(of: userBagReturned))
            print("GOT USER BAG")
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
            var indexOfClub = 0
            for i in 0 ..< userBagReturned.arrayOfArrays[typeOfClubIndex].count {
                print("\nIS \(currentClub) == \(userBagReturned.arrayOfArrays[i])? -- ")
                if currentClub == userBagReturned.arrayOfArrays[typeOfClubIndex][i] {
                    print("YES")
                    indexOfClub = i
                } else {
                    print("NO!!")
                }
//                if userBagReturned.arrayOfArrays[typeOfClubIndex][i].name == currentClub.name {
//                    indexOfClub = i
//                    break
//                }
            }
            let newClub = ClubObject(name: currentClub.name, type: currentClub.type, distance: distAsInt)
//            userBagReturned.arrayOfArrays[typeOfClubIndex][indexOfClub].distance = distAsInt
//            print(userBagReturned.arrayOfArrays[typeOfClubIndex][indexOfClub])
            var newBag = userBagReturned
            newBag.arrayOfArrays[typeOfClubIndex][indexOfClub] = newClub
            mainBag.arrayOfArrays[typeOfClubIndex][indexOfClub] = newClub
            printBagOutLines(bag: userBagReturned)
            doSave(userDefaults: userDefaults, saveThisBag: newBag)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        } catch {
            print(error.localizedDescription)
        }

        // once we call it, let's dismiss this View controller
        navigationController?.popViewController(animated: true)
        
    
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
