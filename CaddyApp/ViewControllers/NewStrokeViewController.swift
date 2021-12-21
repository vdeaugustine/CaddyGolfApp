//
//  NewStrokeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import UIKit



class NewStrokeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var distanceField: UITextField!
    @IBOutlet var useClubLabel: UILabel!
    @IBOutlet var lieTypeSegControl: UISegmentedControl!

    var lieTypeSelected: String = ""
    var StrokeInfo: NewStrokeInfo = NewStrokeInfo(distance: 0, lieType: "")
    var distanceToPin = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        distanceField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Generate", style: .done, target: self, action: #selector(getAdvice))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        saveEnteredDist()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("tapped reutrn")
        saveEnteredDist()
        textField.resignFirstResponder()
        return false
    }

    func saveEnteredDist() {
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return
        }
        if let theDistance = Int(enteredDistance) {
            StrokeInfo.distance = theDistance
        }
    }

    @IBAction func lieSelected() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        switch lieTypeSegControl.selectedSegmentIndex {
        case 0:
            print("Uphill Selected")
            StrokeInfo.lieType = "uphill"
            lieTypeSelected = "uphill"
        case 1:
            print("Downhill Selected")
            StrokeInfo.lieType = "downhill"
            lieTypeSelected = "downhill"
        case 2:
            print("Sidehill Selected")
            StrokeInfo.lieType = "sidehill"
            lieTypeSelected = "sidehill"
        default:
            break
        }
    }

    @IBAction func getAdvice() {
//        saveEnteredDist()
//        print("got advice!")
//        print(StrokeInfo)
        print("GETADVICE")
        distanceField.resignFirstResponder()
        clubForAdvice = getClubForDistance()
        print(clubForAdvice, "club for advice")
        let adviceVC = storyboard?.instantiateViewController(identifier: "advice") as! AdviceViewController
//        print(clubs[indexPath.row])
        adviceVC.title = "Shot Advice"
        navigationController?.pushViewController(adviceVC, animated: true)
    }

    func getClubForDistance() -> ClubObject {
        var shortestClubGap = 999
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return ClubObject(name: "NONE", type: "NONE", fullDistance: 999, threeFourthsDistance: 500, maxDistance: 1000, averageDistance: 0, previousHits: "")
        }

        let distAsInt = Int("\(enteredDistance)")!
        var closestClub = currentClub
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                let thisClubGap = abs(distAsInt - club.fullDistance)
                if thisClubGap < shortestClubGap {
                    shortestClubGap = thisClubGap
                    closestClub = club
                }
            }
        }
        advice.closestClub = closestClub
        advice.closestClubDistance = advice.closestClub.fullDistance
        advice.closestClubGap = shortestClubGap
        advice.distanceToPin = distAsInt
        return closestClub
    }
}
