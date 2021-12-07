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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let theseDistances = getAllDistances(forTheseClubs: clubs)
        print(theseDistances)
        distanceField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Generate", style: .done, target: self, action: #selector(getAdvice))
        
        
        
        // Do any additional setup after loading the view.
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
    
    func saveEnteredDist () {
        //        let distanceToHole : Int = 0
        guard let enteredDistance = distanceField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return
        }
        if let theDistance = Int(enteredDistance) {
            let pickedClub = pickClubFromDistance(clubs, distance: theDistance)
            let thisClubsDist = getDistanceForOneClub(forThisClub: pickedClub)
            useClubLabel.text = "Use \(pickedClub): \(thisClubsDist) yards"
            StrokeInfo.distance = theDistance
        }
        
    }
    
    
    @IBAction func lieSelected() {
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
    
    @objc func getAdvice () {
        saveEnteredDist()
        print("got advice!")
        print(StrokeInfo)
        distanceField.resignFirstResponder()
        let adviceVC = storyboard?.instantiateViewController(identifier: "advice") as! AdviceViewController
//        print(clubs[indexPath.row])
        adviceVC.title = "Shot Advice"
        navigationController?.pushViewController(adviceVC, animated: true)
        
    }
    
    
}

