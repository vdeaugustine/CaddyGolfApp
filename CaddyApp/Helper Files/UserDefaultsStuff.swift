//
//  UserDefaultsStuff.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/29/21.
//

import Foundation

// MARK: The following was in ClubsViewController.viewDidLoad


/// Returns whethe this is the first time this app has been launched. If it is, it sets the 'setup' userDefault to true so it will no longer return true
func isFirstSetup() -> Bool {
    let userDefaults = UserDefaults.standard
    // If there is nothing saved in the UserDefaults (i.e. the first time opening this app)
    if userDefaults.bool(forKey: "setup") {
        return false
    } else {
        userDefaults.setValue(true, forKey: "setup")
        return true
    }
}
