//
//  AddNewClubViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/13/21.
//

import UIKit

class AddNewClubViewController: UIViewController, UITextFieldDelegate {
    // MARK: - VARIABLES/PROPERTIES

    let clubsForPicker: [String] = ["Pitching Wedge", "9 Iron", "8 Iron", "7 Iron", "6 Iron", "5 Iron", "4 Iron", "Driver"]
    var clubTypeSelected = "Wood" // Just default value because it's first on picker
    var clubName = "Driver" // Just default value because it's first on picker
    var clubTypeChangedAtLeastOnce = false
    var clubNumChangedAtLeastOnce = false
    @IBOutlet var clubNumberPicker: UIPickerView!
    @IBOutlet var clubTypeSegment: UISegmentedControl!
    var useThisArrForClubsOptions: [String] = woods
    var typeSelectedIndex : Int = 0
    var numSelectedIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        clubNumberPicker.delegate = self
        clubNumberPicker.dataSource = self
    }

    // MARK: - IBActions

    /// Function that is called when SAVE is tapped to save new club to bag
    @IBAction func saveClub(_ sender: UIBarButtonItem) {
        print("Saved club tapped")

        // Need to get userBag so we can edit it
        let userDefaults = UserDefaults.standard

        do {
            let userBagReturned = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            mainBag = userBagReturned
        } catch {
            print(error.localizedDescription)
        }
            guard !thatClubIsAlreadyInBag(clubName: clubName, bag: mainBag) else {
                print("Already in bag, Not adding it!")
                print("Club: ", clubName)
                print("Bag: ", mainBag)
                _ = navigationController?.popViewController(animated: true)
                return
            }
            print("Club Type Selected \(clubTypeSelected)")
            print("Club Name: ", clubName)
//            if clubTypeSelected == "Wood" {
//                let newClubObject = ClubObject(name: clubName, type: "Wood", distance: 250)
//                mainBag.allClubs2DArray[0].append(newClubObject)
//                mainBag.woodsArray.append(newClubObject)
//
//            } else if clubTypeSelected == "Iron" {
//                let newClubObject = ClubObject(name: clubName, type: "Iron", distance: 150)
//                mainBag.allClubs2DArray[1].append(newClubObject)
//                mainBag.ironsArray.append(newClubObject)
//            } else if clubTypeSelected == "Hybrid" {
//                let newClubObject = ClubObject(name: clubName, type: "Hybrid", distance: 200)
//                mainBag.allClubs2DArray[2].append(newClubObject)
//                mainBag.hybridsArray.append(newClubObject)
//            }
        print("TypeIndex", typeSelectedIndex, "Num Index", numSelectedIndex)
        let newClubObject = ClubObject(name: clubName, type: clubTypeSelected, distance: 999)
        mainBag.allClubs2DArray[typeSelectedIndex].append(newClubObject)
        mainBag.woodsArray = mainBag.allClubs2DArray[0]
        mainBag.ironsArray = mainBag.allClubs2DArray[1]
        mainBag.hybridsArray = mainBag.allClubs2DArray[2]
        doSave(userDefaults: userDefaults, saveThisBag: mainBag)
        // Go back to previous view controller in the navigation stack
        

        _ = navigationController?.popViewController(animated: true)
        }

        

    @IBAction func clubTypeSelected(_ sender: UISegmentedControl) {
        clubTypeChangedAtLeastOnce = true
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        typeSelectedIndex = clubTypeSegment.selectedSegmentIndex
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

// MARK: - UIPicker Handling

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
        clubNumChangedAtLeastOnce = true
        numSelectedIndex = row
        clubName = useThisArrForClubsOptions[row]
    }
}
