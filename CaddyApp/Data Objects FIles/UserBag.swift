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

func sortBag() {
    print("In sort")
    print("Main bag entering sort", mainBag.allClubs2DArray)
    for workingIndex in 0 ..< mainBag.allClubs2DArray.count {
        mainBag.allClubs2DArray[workingIndex] = mainBag.allClubs2DArray[workingIndex].sorted(by: { $0.name < $1.name })
    }

    // Put driver at top
    if !mainBag.allClubs2DArray[0].isEmpty {
        if mainBag.allClubs2DArray[0][mainBag.allClubs2DArray[0].count - 1].name == "Driver" {
            print(mainBag.allClubs2DArray[0].last!, "name")
            let driver = mainBag.allClubs2DArray[0].remove(at: mainBag.allClubs2DArray[0].count - 1)
            mainBag.allClubs2DArray[0].insert(driver, at: 0)
            print(driver)
        }
    }
}

func printArray(_ arr: [ClubObject]) -> String {
    var str = ""
    for club in arr {
        str += "\(club),"
    }
    return str
}
