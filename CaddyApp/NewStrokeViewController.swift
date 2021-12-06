//
//  NewStrokeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import UIKit

class NewStrokeViewController: UIViewController {

    let clubs : [String] = ["Pitching Wedge", "9 Iron", "8 Iron","7 Iron","6 Iron","5 Iron"]
    override func viewDidLoad() {
        super.viewDidLoad()
        var these_distances = getAllDistances(forTheseClubs: clubs)
        print(these_distances)

        // Do any additional setup after loading the view.
    }
    

}
