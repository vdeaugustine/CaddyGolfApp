//
//  UserBag.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/12/21.
//

import Foundation
import UIKit

struct UserBag: Codable {
    var types: [String]
    var clubsArray: [ClubObject]
    var ironsArray: [ClubObject]
    var hybridsArray: [ClubObject]
    var woodsArray: [ClubObject]
    /// This is an array that holds an individual array for each type of club. So inside this main array will be a WoodsArray, IronsArray, HybridsArray, and WedgesArray in that order
    var arrayOfArrays: [[ClubObject]]
}

struct ClubObject: Codable {
    var name: String
    var type: String
    var distance: Int
}

func defaultBag() -> UserBag {
    let typesOfClubs = ["Woods", "Irons", "Hybrids"]

    var clubsArray = [ClubObject]()
    var ironsArray = [ClubObject]()
    var woodsArray = [ClubObject]()
    var hybridsArray = [ClubObject]()

    let driver = ClubObject(name: "Driver", type: "Wood", distance: 275)
    clubsArray.append(driver)
    woodsArray.append(driver)

    let fourIron = ClubObject(name: "4 Iron", type: "Iron", distance: 190)
    clubsArray.append(fourIron)
    ironsArray.append(fourIron)
    let threeHybrid = ClubObject(name: "3 Hybrid", type: "Hybrid", distance: 210)
    clubsArray.append(threeHybrid)
    hybridsArray.append(threeHybrid)

    return UserBag(types: typesOfClubs,
                   clubsArray: clubsArray,
                   ironsArray: ironsArray,
                   hybridsArray: hybridsArray,
                   woodsArray: woodsArray,
                   arrayOfArrays: [woodsArray, ironsArray, hybridsArray])
}

func thatClubIsAlreadyInBag(clubName: String, bag: UserBag) -> Bool {
    for clubType in bag.arrayOfArrays {
        for nameOfClub in clubType {
            if clubName == nameOfClub.name {
                return true
            }
        }
    }
    return false
}

func sortBag(bag: UserBag) -> UserBag {
    let sortedIrons: [ClubObject] = bag.ironsArray.sorted(by: { $0.name < $1.name })
    var sortedWoods: [ClubObject] = bag.woodsArray.sorted(by: { $0.name < $1.name })
    let sortedHybrids: [ClubObject] = bag.hybridsArray.sorted(by: { $0.name < $1.name })
    let driver = sortedWoods.remove(at: sortedWoods.count-1)
    sortedWoods.insert(driver, at: 0)
    let allSortedClubs = sortedIrons + sortedWoods + sortedHybrids
    
    
    
    return UserBag(types: ["Woods", "Irons", "Hybrids"],
                   clubsArray: allSortedClubs,
                   ironsArray: sortedIrons,
                   hybridsArray: sortedHybrids,
                   woodsArray: sortedWoods,
                   arrayOfArrays: [sortedWoods, sortedIrons, sortedHybrids])
}
