//
//  NewStrokeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import UIKit

var clubBelowForAdvice = currentClub
var clubAboveForAdvice = currentClub
var advice = Advice()

class NewStrokeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var distanceField: UITextField!
    @IBOutlet var useClubLabel: UILabel!
    @IBOutlet var lieTypeSegControl: UISegmentedControl!
    @IBOutlet var shotType: UISegmentedControl!
    @IBOutlet var shotTypeLabel: UILabel!
    @IBOutlet var lieTypeLabel: UILabel!
    @IBOutlet var distanceToPinLabel: UILabel!

    var lieTypeSelected: String = ""
    var StrokeInfo: NewStrokeInfo = NewStrokeInfo(distance: 0, lieType: "")
    var distanceToPin = 0

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        distanceField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Advice", style: .done, target: self, action: #selector(getAdvice))
        distanceField.translatesAutoresizingMaskIntoConstraints = false

    }

    override func viewWillAppear(_ animated: Bool) {
        distanceField.placeholder = "0"
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = ""
        return true
    }

    func saveEnteredDist() {
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            distanceField.placeholder = "0"
            return
        }
        if let theDistance = Int(enteredDistance) {
            StrokeInfo.distance = theDistance
        }
    }

    @IBAction func lieSelected() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
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

    @IBAction func shotTypeSelected(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred(intensity: 1.0)
        switch shotType.selectedSegmentIndex {
        case 0:
            print("Tee Shot Selected")

        case 1:
            print("Approach Shot Selected")

        case 2:
            print("Pitch Shot Selected")

        case 3:
            print("Chip Shot Selected")
        default:
            break
        }
    }

    @IBAction func getAdvice() {
        print("GETADVICE")
        distanceField.resignFirstResponder()
        clubBelowForAdvice = getClubBelow()
        clubAboveForAdvice = getClubAbove()
        print(clubBelowForAdvice, "club for advice")
//        let adviceVC = storyboard?.instantiateViewController(identifier: "AdviceViewController") as! AdviceViewController
        let adviceVC = storyboard?.instantiateViewController(identifier: "NewAdviceViewController") as! NewAdviceViewController
        
        adviceVC.title = "Shot Advice"
        navigationController?.pushViewController(adviceVC, animated: true)
    }

    func getClubBelow() -> ClubObject {
        var shortestClubGap = 999
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return ClubObject(name: "NONE", type: "NONE", fullDistance: 999, threeFourthsDistance: 500, maxDistance: 1000, averageFullDistance: 0, previousFullHits: "")
        }

        let distAsInt = Int("\(enteredDistance)")!
        var closestClub = currentClub
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                if club.fullDistance <= distAsInt {
                    let thisClubGap = abs(distAsInt - club.fullDistance)
                    if thisClubGap < shortestClubGap {
                        shortestClubGap = thisClubGap
                        closestClub = club
                    }
                }
            }
        }
        advice.closestClubBelow = closestClub
        advice.clubBelowDistance = advice.closestClubBelow.fullDistance
        advice.clubBelowGap = shortestClubGap
        advice.distanceToPin = distAsInt
        return closestClub
    }

    func getClubAbove() -> ClubObject {
        var shortestClubGap = 999
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return ClubObject(name: "NONE", type: "NONE", fullDistance: 999, threeFourthsDistance: 500, maxDistance: 1000, averageFullDistance: 0, previousFullHits: "")
        }

        let distAsInt = Int("\(enteredDistance)")!
        var closestClub = currentClub
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                if club.fullDistance >= distAsInt {
                    let thisClubGap = abs(club.fullDistance - distAsInt)
                    if thisClubGap < shortestClubGap {
                        shortestClubGap = thisClubGap
                        closestClub = club
                    }
                }
            }
        }
        advice.closestClubAbove = closestClub
        advice.clubAboveDistance = advice.closestClubAbove.fullDistance
        advice.clubAboveGap = shortestClubGap
        advice.distanceToPin = distAsInt
        return closestClub
    }
}
