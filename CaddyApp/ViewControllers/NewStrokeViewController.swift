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
var closestClubBelow = ClosestClubBelow(gap: 999, clubName: currentClub.name, swingType: .fullSwing)

class NewStrokeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var distanceField: UITextField!
    @IBOutlet var useClubLabel: UILabel!
    @IBOutlet var lieTypeSegControl: UISegmentedControl!
    @IBOutlet var flagColorSwgControl: UISegmentedControl!
    @IBOutlet var flagColorLabel: UILabel!
    @IBOutlet var lieTypeLabel: UILabel!
    @IBOutlet var distanceToPinLabel: UILabel!
    @IBOutlet var moreInfoButton: UIButton!

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
//        distanceField.translatesAutoresizingMaskIntoConstraints = false
//        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
//        distanceToPinLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        moreInfoButton.centerYAnchor.constraint(equalTo: distanceToPinLabel.centerYAnchor).isActive = true
//        moreInfoButton.heightAnchor.constraint(equalTo: distanceToPinLabel.heightAnchor, multiplier: 1/3).isActive = true
//        moreInfoButton.leadingAnchor.constraint(equalTo: distanceToPinLabel.trailingAnchor, constant: 3).isActive = true
//        moreInfoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
//        moreInfoButton.widthAnchor.constraint(equalTo: moreInfoButton.heightAnchor).isActive = true
//        moreInfoButton.bottomAnchor.constraint(equalTo: flagColorSwgControl.topAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)
        distanceField.placeholder = "0"
//        for item in self.view.subviews {
//            item.translatesAutoresizingMaskIntoConstraints = false
//        }
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

    @IBAction func flagColorChanged(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred(intensity: 1.0)
        switch flagColorSwgControl.selectedSegmentIndex {
        case 0:
            print("Red Selected")
            advice.flagColor = "Red"

        case 1:
            print("White Selected")
            advice.flagColor = "White"

        case 2:
            print("Blue Selected")
            advice.flagColor = "Blue"

        default:
            break
        }
    }

    @IBAction func getAdvice() {
        print("GETADVICE")
        playSound(whichSound: "Swing")

        distanceField.resignFirstResponder()
        clubBelowForAdvice = getClubBelow()
        clubAboveForAdvice = getClubAbove()
        print(clubBelowForAdvice, "club for advice")
        let adviceVC = storyboard?.instantiateViewController(identifier: "AdviceViewController") as! AdviceViewController

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
        var closestClub = getLowestClub()
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                if club.fullDistance <= distAsInt {
                    let thisClubGap = abs(distAsInt - club.fullDistance)
                    if thisClubGap < shortestClubGap {
                        shortestClubGap = thisClubGap
                        closestClub = club
//                        closestClubBelow = ClosestClubBelow(gap: thisClubGap, clubName: club.name, swingType: .fullSwing)
                    }
                }

//                if useSwingTypes {
//                    if club.threeFourthsDistance <= distAsInt {
//                        let thisClubGap = abs(distAsInt - club.threeFourthsDistance)
//                        if thisClubGap < shortestClubGap {
//                            shortestClubGap = thisClubGap
//                            closestClub = club
//                            closestClubBelow = ClosestClubBelow(gap: thisClubGap, clubName: club.name, swingType: .threeFourths)
//                        }
//                    }
//                    if club.maxDistance <= distAsInt {
//                        let thisClubGap = abs(distAsInt - club.maxDistance)
//                        if thisClubGap < shortestClubGap {
//                            shortestClubGap = thisClubGap
//                            closestClub = club
//                            closestClubBelow = ClosestClubBelow(gap: thisClubGap, clubName: club.name, swingType: .maxSwing)
//                        }
//                    }
//                }
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
        var closestClub = getHighestClub()
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                if club.fullDistance >= distAsInt {
                    let thisClubGap = abs(club.fullDistance - distAsInt)
                    if thisClubGap < shortestClubGap {
                        shortestClubGap = thisClubGap
                        closestClub = club
                    }
                }

//                if useSwingTypes {
//                    if club.threeFourthsDistance >= distAsInt {
//                        let thisClubGap = abs(distAsInt - club.threeFourthsDistance)
//                        if thisClubGap < shortestClubGap {
//                            shortestClubGap = thisClubGap
//                            closestClub = club
//                            closestClubBelow = ClosestClubBelow(gap: thisClubGap, clubName: club.name, swingType: .threeFourths)
//                        }
//                    }
//                    if club.maxDistance >= distAsInt {
//                        let thisClubGap = abs(distAsInt - club.maxDistance)
//                        if thisClubGap < shortestClubGap {
//                            shortestClubGap = thisClubGap
//                            closestClub = club
//                            closestClubBelow = ClosestClubBelow(gap: thisClubGap, clubName: club.name, swingType: .maxSwing)
//                        }
//                    }
//                }
            }
        }
        advice.closestClubAbove = closestClub
        advice.clubAboveDistance = advice.closestClubAbove.fullDistance
        advice.clubAboveGap = shortestClubGap
        advice.distanceToPin = distAsInt
        return closestClub
    }

    @IBAction func tappedMoreInfo() {
        let alert = UIAlertController(title: "Flag Colors",
                                      message: "Flag colors indicate the pin placement on the green.\n\nA red flag means the pin is in the front of the green.\n\nA white flag means the pin is in the middle of the green.\n\nA blue flag means the pin is in the back of the green",
                                      preferredStyle: .alert)

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
}
