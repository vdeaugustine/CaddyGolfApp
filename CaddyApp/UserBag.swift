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
    var allClubs2DArray: [[ClubObject]]
}

struct ClubObject: Codable, CustomStringConvertible, Equatable {
    var name: String
    var type: String
    var distance: Int
    var description: String {
        return "\(name)-\(distance)".uppercased()
    }

    public static func == (lhs: ClubObject, rhs: ClubObject) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}

func defaultBag() -> UserBag {
    
    print("\nCALLING DEFAULT BAG FOR SOME REASON\n")
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
                   allClubs2DArray: [woodsArray, ironsArray, hybridsArray])
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

func clubAlreadyInBag(club: ClubObject, bag: UserBag) -> Bool {
    for clubType in bag.allClubs2DArray {
        for thisClub in clubType {
            if thisClub == club {
                return true
            }
        }
    }
    return false
}

func sortBag(bag: inout UserBag) {
    print("In sort")
    printBagOutLines(bag: bag)
    let sortedIrons: [ClubObject] = bag.ironsArray.sorted(by: { $0.name < $1.name })
    var sortedWoods: [ClubObject] = bag.woodsArray.sorted(by: { $0.name < $1.name })
    let sortedHybrids: [ClubObject] = bag.hybridsArray.sorted(by: { $0.name < $1.name })
    let driver = sortedWoods.remove(at: sortedWoods.count - 1)
    sortedWoods.insert(driver, at: 0)
    let allSortedClubs = sortedWoods + sortedIrons + sortedHybrids
    
    bag.ironsArray = sortedIrons
    bag.woodsArray = sortedWoods
    bag.hybridsArray = sortedHybrids
    bag.allClubs2DArray = [sortedWoods, sortedIrons, sortedHybrids]
    bag.clubsArray = allSortedClubs
}

//func removeDuplicates(bag: UserBag) -> UserBag {
//
//    var newBag = bag
//
//    for ind in 0..<newBag.ironsArray.count - 1 {
//        if newBag[ind] ==
//        
//    }
//
//    for wood in newBag.woodsArray {
//
//    }
//
//    for hybrid in newBag.hybridsArray {
//
//    }
//
//    return newBag
//
//
//}
