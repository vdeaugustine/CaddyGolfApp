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
var allClubsByType = [woods, hybrids, irons, wedges]
var clubsInUserBag = woods + hybrids + irons + wedges
var ironsInUserBag = irons
var woodsInuserBag = woods
var hybridsInuserBag = hybrids
var wedgesInuserBag = wedges

func getClubTypesInBag (in userBag: [String]) -> [String] {
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

func getUserBag() -> [String]{
    var userBagReturned = [String]()
    let userD = UserDefaults()
    
    // Get Woods
    for wood in woods {
        if let thisWood = userD.value(forKey: wood){
            userBagReturned.append(thisWood as! String)
        }
    }
    
    // Get Irons
    for iron in irons {
        if let thisIron = userD.value(forKey: iron){
            userBagReturned.append(thisIron as! String)
        }
    }
    
    // Get Hybrids
    for hybrid in hybrids {
        if let thisHybrid = userD.value(forKey: hybrid){
            userBagReturned.append(thisHybrid as! String)
        }
    }
    
    // Get Wedges
    
    
    return userBagReturned
}


//struct ClubObject {
//    var clubType: String
//    var clubOptions: [String]
//}
//
//func setUpClubObjects() -> [ClubObject] {
//    var clubsList = [ClubObject]()
//    clubsList.append(ClubObject(clubType: "Woods", clubOptions: woods))
//    clubsList.append(ClubObject(clubType: "Hybrids", clubOptions: hybrids))
//    clubsList.append(ClubObject(clubType: "Irons", clubOptions: irons))
//
//    return clubsList
//}
//
//// func deleteClub(firstIndex: Int, secondIndex: Int, from thisArray: [[String]]) {
////    var tempArr = thisArray
////    tempArr = tempArr[firstIndex].remove(at: secondIndex)
//// }
//
//
//func setClubsToDefault() -> [Club] {
//    var allClubs: [Club] = []
//
//    // Set up Woods
//    allClubs.append(Club(clubType: "wood", clubName: "Driver", userDistance: 275))
//    allClubs.append(Club(clubType: "wood", clubName: "2 Wood", userDistance: 250))
//    allClubs.append(Club(clubType: "wood", clubName: "3 Wood", userDistance: 230))
//    allClubs.append(Club(clubType: "wood", clubName: "4 Wood", userDistance: 215))
//    allClubs.append(Club(clubType: "wood", clubName: "5 Wood", userDistance: 200))
//
//    // Set up Hybrids
//    allClubs.append(Club(clubType: "hybrid", clubName: "1 Hybrid", userDistance: 220))
//    allClubs.append(Club(clubType: "hybrid", clubName: "2 Hybrid", userDistance: 210))
//    allClubs.append(Club(clubType: "hybrid", clubName: "3 Hybrid", userDistance: 200))
//    allClubs.append(Club(clubType: "hybrid", clubName: "4 Hybrid", userDistance: 190))
//    allClubs.append(Club(clubType: "hybrid", clubName: "5 Hybrid", userDistance: 180))
//
//    // Set up Irons
//    allClubs.append(Club(clubType: "iron", clubName: "1 Iron", userDistance: 220))
//    allClubs.append(Club(clubType: "iron", clubName: "2 Iron", userDistance: 210))
//    allClubs.append(Club(clubType: "iron", clubName: "3 Iron", userDistance: 200))
//    allClubs.append(Club(clubType: "iron", clubName: "4 Iron", userDistance: 190))
//    allClubs.append(Club(clubType: "iron", clubName: "5 Iron", userDistance: 180))
//    allClubs.append(Club(clubType: "iron", clubName: "6 Iron", userDistance: 170))
//    allClubs.append(Club(clubType: "iron", clubName: "7 Iron", userDistance: 160))
//    allClubs.append(Club(clubType: "iron", clubName: "8 Iron", userDistance: 150))
//    allClubs.append(Club(clubType: "iron", clubName: "9 Iron", userDistance: 140))
//
//
//    // Set up Wedges
//    allClubs.append(Club(clubType: "wedge", clubName: "48 Wedge", userDistance: 110))
//    allClubs.append(Club(clubType: "wedge", clubName: "50 Wedge", userDistance: 100))
//    allClubs.append(Club(clubType: "wedge", clubName: "52 Wedge", userDistance: 90))
//    allClubs.append(Club(clubType: "wedge", clubName: "54 Wedge", userDistance: 80))
//    allClubs.append(Club(clubType: "wedge", clubName: "56 Wedge", userDistance: 70))
//    allClubs.append(Club(clubType: "wedge", clubName: "60 Wedge", userDistance: 60))
//
//    return allClubs
//}
//
//struct Club {
//    var clubType: String
//    var clubName: String
//    var userDistance: Int = 145
//}
//
//
//
