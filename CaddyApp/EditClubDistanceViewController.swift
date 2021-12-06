//
//  EditClubDistanceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/4/21.
//

import UIKit

class EditClubDistanceViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var currentDistanceLabel: UILabel!
    
    @IBOutlet var clubTextField : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTextField.delegate = self
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveClub))
        
        
        guard let dist = UserDefaults().value(forKey: "\(currentClub)") as? Int else {
            print("Not an int!!!")
            return
        }
        print("Curr dist issss \(dist)")
        currentDistanceLabel?.text = "Current Distance: \(dist)"
    }
    
    
    @objc func saveClub() {
        guard let enteredDistance = clubTextField.text, !enteredDistance.isEmpty, enteredDistance.isInt else {
            print("Text entered is either not int or empty")
            return
        }
        
        // we have to use this Guard statement because Swift is not aware that we already set up this account variable in another view controller. So we have to make sure that we open the optional carefully
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//        let newCount = count + 1
//        UserDefaults().set(newCount, forKey: "count")
        print("Setting \(enteredDistance) as distance for \(currentClub)")
        UserDefaults().set(Int(enteredDistance), forKey: "\(currentClub)")
        
        
        // this is saying if this update function exists, let's call it
//            update?()
        
        // once we call it, let's dismiss this View controller
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
