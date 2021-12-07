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
        
        
//        guard let dist = UserDefaults().value(forKey: "\(currentClub)") as? Int else {
//            print("Not an int!!!")
//            print("Has type \(type(of: UserDefaults().value(forKey: "\(currentClub)")))")
//            return
//        }
        if let dist = Int("\(UserDefaults().value(forKey: "\(currentClub)") ?? "PROBLEM IN EDITCLUBDIST")") {
            currentDistanceLabel?.text = "Current Distance: \(dist)"
        }
        
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
                switch action.style{
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
            self.present(alert, animated: true, completion: nil)
        }
        
        print("Setting \(enteredDistance) as distance for \(currentClub)")
        UserDefaults().set(Int(enteredDistance), forKey: "\(currentClub)")
        
        
        // once we call it, let's dismiss this View controller
        navigationController?.popViewController(animated: true)
    }

}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
