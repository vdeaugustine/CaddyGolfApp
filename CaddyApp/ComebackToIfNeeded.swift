//
//  ComebackToIfNeeded.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/20/21.
//

import Foundation
///// Function that will be called when the user hits save button at top of screen.
///// Function will add the newly updated user bag to the UserDefaults, and update global mainBag variable
//@objc func saveClub() {
//    // Make sure that the info entered into the text field is appropriate
//    guard let enteredDistance = clubTextField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
//        print("Text entered is either not int or empty")
//        return
//    }
//
//    let distAsInt = Int("\(enteredDistance)")! // The value that will be saved to ClubObject as distance
//    // Send an alert to the user if they put in a ridiculous yardage amount
//    if distAsInt > 450 {
//        let alert = UIAlertController(title: "\(distAsInt)? Really?", message: "Come on, let's be realistic lol", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            switch action.style {
//            case .default:
//                print("default")
//
//            case .cancel:
//                print("cancel")
//
//            case .destructive:
//                print("destructive")
//
//            @unknown default:
//                print("whateverIDC")
//            }
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//
//    print("Setting \(enteredDistance) as distance for \(currentClub)")
//
//    // Need to get userBag so we can edit it
//    let userDefaults = UserDefaults.standard
//    do {
//        let userBagReturned = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
//        mainBag = userBagReturned
//    } catch {
//        print(error.localizedDescription)
//    }
//
//    print(type(of: mainBag))
////        print("GOT USER BAG")
//    /// This will be used to figure out which type of club it is, so we can find which sub-array it belongs to
//    var typeOfClubIndex: Int = 0
//    if currentClub.type == "Wood" {
//        typeOfClubIndex = 0
//    } else if currentClub.type == "Iron" {
//        typeOfClubIndex = 1
//    } else if currentClub.type == "Hybrid" {
//        typeOfClubIndex = 2
//    } else if currentClub.type == "Wedge" {
//        typeOfClubIndex = 3
//    } else {
//        print("\nERROR ERROR. CLUB TYPE NOT FOUND")
//    }
//    // Go through the subindex of 2DArray (index of club type we are looking for) and find the index for the club itself
//    var indexOfClub = 0
//    for i in 0 ..< mainBag.allClubs2DArray[typeOfClubIndex].count {
//        print("\nIS \(currentClub) == \(mainBag.allClubs2DArray[i])? -- ")
//        if currentClub == mainBag.allClubs2DArray[typeOfClubIndex][i] {
//            print("YES")
//            indexOfClub = i
//        } else {
//            print("NO!!")
//        }
//    }
//    let newClub = ClubObject(name: currentClub.name, type: currentClub.type, fullDistance: distAsInt, threeFourthsDistance: Int(Double(distAsInt) * 0.75), maxDistance: Int(Double(distAsInt) * 1.25), averageDistance: 0, previousHits: "")
//    mainBag.allClubs2DArray[typeOfClubIndex][indexOfClub] = newClub
//
//    // Save the bag to the defaults
//    doSave(userDefaults: userDefaults, saveThisBag: mainBag)
//
//
//    // MARK: - Core Data Save
////        createItem(name: currentClub.name, typeOfClub: distAsInt)
//
//
//    // Once we call it, let's dismiss this View controller
////        navigationController?.popViewController(animated: true)
//    let tempViewController = storyboard?.instantiateViewController(identifier: "TestTableViewController") as! TestTableViewController
//    navigationController?.pushViewController(tempViewController, animated: true)
//}
