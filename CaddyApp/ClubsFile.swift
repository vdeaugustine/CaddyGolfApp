//
//  ClubsFile.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/6/21.
//

import Foundation
import UIKit




let clubTypes: [String] = ["Woods", "Hybrids", "Irons", "Wedges"]
let clubs: [String] = ["Pitching Wedge", "9 Iron", "8 Iron", "7 Iron", "6 Iron", "5 Iron", "4 Iron", "Driver"]
let woods: [String] = ["Driver", "2 Wood", "3 Wood", "4 Wood", "5 Wood"]
let hybrids: [String] = ["1 Hybrid", "2 Hybrid", "3 Hybrid", "4 Hybrid", "5 Hybrid"]
let irons: [String] = ["9 Iron", "8 Iron", "7 Iron", "6 Iron", "5 Iron", "4 Iron", "3 Iron", "2 Iron", "1 Iron"]
let wedges: [String] = ["Pitching Wedge", "52 Wedge", "54 Wedge", "56 Wedge", "58 Wedge", "60 Wedge"]
let everySingleClub: [String] = woods + hybrids + irons + wedges
var allClubsByType = [woods, hybrids, irons, wedges]
var clubsInUserBag = woods + hybrids + irons + wedges
var ironsInUserBag = irons
var woodsInuserBag = woods
var hybridsInuserBag = hybrids
var wedgesInuserBag = wedges

func getClubTypesInBag(in userBag: [String]) -> [String] {
    /// Returns a set converted to array. Should have at most 4 unique items (Woods, Irons, Hybrids, Wedges)

    var clubTypesInBag = Set<String>()

    for item in userBag {
        if item.contains("Iron") {
            clubTypesInBag.insert("Irons")
        }
        if item.contains("Wood") || item.contains("Driver") {
            clubTypesInBag.insert("Woods")
        }
        if item.contains("Hybrid") {
            clubTypesInBag.insert("Hybrids")
        }
        if item.contains("Wedge") {
            clubTypesInBag.insert("Wedges")
        }
    }

    return Array(clubTypesInBag)
}

func getUserBag() -> [String] {
    var userBagReturned = [String]()
    let userD = UserDefaults()

    // Get Woods
    for wood in woods {
        if let thisWood = userD.value(forKey: wood) {
            userBagReturned.append(thisWood as! String)
        }
    }

    // Get Irons
    for iron in irons {
        if let thisIron = userD.value(forKey: iron) {
            userBagReturned.append(thisIron as! String)
        }
    }

    // Get Hybrids
    for hybrid in hybrids {
        if let thisHybrid = userD.value(forKey: hybrid) {
            userBagReturned.append(thisHybrid as! String)
        }
    }

    // Get Wedges

    return userBagReturned
}
