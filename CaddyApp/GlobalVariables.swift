//
//  GlobalVariables.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/20/21.
//

import Foundation
import UIKit


/// This has to be a global variable. If it is a property of the ClubsViewController class, it will be reinitialized every time the view is loaded, leading to the table values being screwed up.
var currentClubCORE = SingleClub(context: coreDataContext)

var clubForAdvice = currentClubCORE
var advice = Advice()
