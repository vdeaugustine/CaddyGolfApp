//
//  GlobalVariables.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/30/21.
//

import Foundation
import UIKit
var currentClub: ClubObject = ClubObject(name: "Driver", type: "Wood", fullDistance: 275, threeFourthsDistance: 265, maxDistance: 285, averageFullDistance: 0, previousFullHits: "")

/// This has to be a global variable. If it is a property of the ClubsViewController class, it will be reinitialized every time the view is loaded, leading to the table values being screwed up.
var mainBag: UserBag = defaultBag()

var currentSwingType: swingTypeState = .threeFourths

let globalCornerRadius: CGFloat = 8

// let mastersGreen = UIColor(red: 7, green: 102, blue: 82, alpha: 1.0)
let myGreen = UIColor(rgb: 0x076652)
let myYellow = UIColor(rgb: 0xE5D743)