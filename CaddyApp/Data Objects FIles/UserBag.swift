//
//  UserBag.swift
//  CaddyApp
//
//  Created by Vincent   on 12/12/21.
//

import Foundation
import UIKit

struct UserBag: Codable {
    var types: [String]
    var clubsArray: [ClubObject]
    var ironsArray: [ClubObject]
    var hybridsArray: [ClubObject]
    var woodsArray: [ClubObject]
    var wedgesArray: [ClubObject]
    /// This is an array that holds an individual array for each type of club. So inside this main array will be a WoodsArray, IronsArray, HybridsArray, and WedgesArray in that order
    var allClubs2DArray: [[ClubObject]]
}

func defaultBag() -> UserBag {
    print("\nCALLING DEFAULT BAG FOR SOME REASON\n")
    let typesOfClubs = ["Woods", "Irons", "Hybrids", "Wedges"]

    var clubsArray = [ClubObject]()
    var ironsArray = [ClubObject]()
    var woodsArray = [ClubObject]()
    var hybridsArray = [ClubObject]()
    var wedgesArray = [ClubObject]()

    let driver = ClubObject(name: "Driver", type: "Wood", fullDistance: 275, threeFourthsDistance: 265, maxDistance: 285, averageDistance: 0, previousHits: "")
    clubsArray.append(driver)
    woodsArray.append(driver)

//    let fourIron = ClubObject(name: "4 Iron", type: "Iron", distance: 190)
//    clubsArray.append(fourIron)
//    ironsArray.append(fourIron)
    let threeHybrid = ClubObject(name: "3 Hybrid", type: "Hybrid", fullDistance: 210, threeFourthsDistance: 200, maxDistance: 220, averageDistance: 0, previousHits: "")
    clubsArray.append(threeHybrid)
    hybridsArray.append(threeHybrid)

    ironsArray.append(ClubObject(name: "3 Iron", type: "Iron", fullDistance: 205, threeFourthsDistance: 200, maxDistance: 215, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "4 Iron", type: "Iron", fullDistance: 195, threeFourthsDistance: 185, maxDistance: 205, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "5 Iron", type: "Iron", fullDistance: 185, threeFourthsDistance: 175, maxDistance: 195, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "6 Iron", type: "Iron", fullDistance: 175, threeFourthsDistance: 165, maxDistance: 185, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "7 Iron", type: "Iron", fullDistance: 165, threeFourthsDistance: 155, maxDistance: 175, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "8 Iron", type: "Iron", fullDistance: 155, threeFourthsDistance: 145, maxDistance: 165, averageDistance: 0, previousHits: ""))
    ironsArray.append(ClubObject(name: "9 Iron", type: "Iron", fullDistance: 145, threeFourthsDistance: 135, maxDistance: 155, averageDistance: 0, previousHits: ""))

    clubsArray.append(ClubObject(name: "3 Iron", type: "Iron", fullDistance: 205, threeFourthsDistance: 195, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "4 Iron", type: "Iron", fullDistance: 195, threeFourthsDistance: 185, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "5 Iron", type: "Iron", fullDistance: 185, threeFourthsDistance: 175, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "6 Iron", type: "Iron", fullDistance: 175, threeFourthsDistance: 165, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "7 Iron", type: "Iron", fullDistance: 165, threeFourthsDistance: 155, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "8 Iron", type: "Iron", fullDistance: 155, threeFourthsDistance: 145, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "9 Iron", type: "Iron", fullDistance: 145, threeFourthsDistance: 135, maxDistance: 220, averageDistance: 0, previousHits: ""))

    clubsArray.append(ClubObject(name: "3 wood", type: "Wood", fullDistance: 195, threeFourthsDistance: 185, maxDistance: 220, averageDistance: 0, previousHits: ""))
    clubsArray.append(ClubObject(name: "5 wood", type: "Wood", fullDistance: 185, threeFourthsDistance: 175, maxDistance: 220, averageDistance: 0, previousHits: ""))

    woodsArray.append(ClubObject(name: "3 wood", type: "Wood", fullDistance: 195, threeFourthsDistance: 185, maxDistance: 220, averageDistance: 0, previousHits: ""))
    woodsArray.append(ClubObject(name: "5 wood", type: "Wood", fullDistance: 185, threeFourthsDistance: 175, maxDistance: 220, averageDistance: 0, previousHits: ""))

    wedgesArray.append(ClubObject(name: "52 Wedge", type: "Wedge", fullDistance: 115, threeFourthsDistance: 105, maxDistance: 220, averageDistance: 0, previousHits: ""))
    wedgesArray.append(ClubObject(name: "60 Wedge", type: "Wedge", fullDistance: 60, threeFourthsDistance: 95, maxDistance: 220, averageDistance: 0, previousHits: ""))

    return UserBag(types: typesOfClubs,
                   clubsArray: clubsArray,
                   ironsArray: ironsArray,
                   hybridsArray: hybridsArray,
                   woodsArray: woodsArray,
                   wedgesArray: wedgesArray,
                   allClubs2DArray: [woodsArray, ironsArray, hybridsArray, wedgesArray])
}

func thatClubIsAlreadyInBag(clubName: String, bag: UserBag) -> Bool {
    for clubType in bag.allClubs2DArray {
        for nameOfClub in clubType {
            if clubName == nameOfClub.name {
                return true
            }
        }
    }
    return false
}

func clubAlreadyInBag(club: String, bag: UserBag) -> Bool {
    for clubType in bag.allClubs2DArray {
        for thisClub in clubType {
            if thisClub.name == club {
                return true
            }
        }
    }
    return false
}

func sortBag() {
 
}
