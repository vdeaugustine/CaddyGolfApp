//
//  AddNewClubViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/13/21.
//

import UIKit

class AddNewClubViewController: UIViewController, UITextFieldDelegate {
    let clubsForPicker: [String] = ["Pitching Wedge", "9 Iron", "8 Iron", "7 Iron", "6 Iron", "5 Iron", "4 Iron", "Driver"]
    var clubTypeSelected = "Wood"
    var clubName = "Driver"
    @IBOutlet var clubNumberPicker: UIPickerView!
    @IBOutlet var clubTypeSegment: UISegmentedControl!
    var useThisArrForClubsOptions: [String] = woods

    @IBAction func clubTypeSelectedBySegment() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        switch clubTypeSegment.selectedSegmentIndex {
        case 0:
            print("Wood Selected")

        case 1:
            print("Iron Selected")

        case 2:
            print("Hybrid Selected")

        default:
            break
        }
    }

    @IBAction func SaveClub(_ sender: UIBarButtonItem) {
        // Need to get userBag so we can edit it
        let userDefaults = UserDefaults.standard
        do {
            var userBagReturned = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            print("Going to save")
            print("Club Type Selected \(clubTypeSelected)")
            print("Club Name: ", clubName)
            if clubTypeSelected == "Wood" {
                print("\n\nREACHED WOOD THING\n\n")
                let newClubObject = ClubObject(name: clubName, type: "Wood", distance: 250)
                userBagReturned.arrayOfArrays[0].append(newClubObject)
                userBagReturned.woodsArray.append(newClubObject)

            } else if clubTypeSelected == "Iron" {
                let newClubObject = ClubObject(name: clubName, type: "Iron", distance: 150)
                userBagReturned.arrayOfArrays[1].append(newClubObject)
                userBagReturned.ironsArray.append(newClubObject)
            } else if clubTypeSelected == "Hybrid" {
                let newClubObject = ClubObject(name: clubName, type: "Hybrid", distance: 200)
                userBagReturned.arrayOfArrays[2].append(newClubObject)
                userBagReturned.hybridsArray.append(newClubObject)
            }
            print("\n\nBEFORE SAVE")
            printBagOutLines(bag: userBagReturned)

            doSave(userDefaults: userDefaults, saveThisBag: userBagReturned)
        } catch {
            print(error.localizedDescription)
        }

        // Go back to previous view controller in the navigation stack

        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        clubNumberPicker.delegate = self
        clubNumberPicker.dataSource = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        clubNumberPicker.resignFirstResponder()
    }

    @IBAction func ClubTypeSelected(_ sender: UISegmentedControl) {
        switch clubTypeSegment.selectedSegmentIndex {
        case 0:
            print("Wood Selected")
            clubTypeSelected = "Wood"
            useThisArrForClubsOptions = woods
            clubNumberPicker.reloadAllComponents()
        case 1:
            print("Iron Selected")
            clubTypeSelected = "Iron"
            useThisArrForClubsOptions = irons
            clubNumberPicker.reloadAllComponents()
        case 2:
            print("Hybrid Selected")
            clubTypeSelected = "Hybrid"
            useThisArrForClubsOptions = hybrids
            clubNumberPicker.reloadAllComponents()
        default:
            break
        }
    }
}

extension AddNewClubViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return useThisArrForClubsOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return useThisArrForClubsOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected \(useThisArrForClubsOptions[row])")
        clubName = useThisArrForClubsOptions[row]
    }
}
