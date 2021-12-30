//
//  SomeFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import Foundation
import UIKit

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

func getAllDistances(forTheseClubs clubs: [String]) -> [Int] {
    var distances = [Int]()
    for clubType in clubs {
        if let dis = UserDefaults().value(forKey: "\(clubType)") {
            // Hacky way to get the UserDefaults values to ints to be returned
            let disStr = "\(dis)"
            if let disInt = Int(disStr) {
                distances.append(disInt)
            }
        } else {
            print("\(clubType) does not have any value set yet")
        }
    }
    return distances
}

func getDistanceForOneClub(forThisClub club: String) -> String {
    var thisClubsDistance: String = ""
    if let dis = UserDefaults().value(forKey: "\(club)") {
        thisClubsDistance = "\(dis)"
    }

    return thisClubsDistance
}

func setUpDefaults() {
    UserDefaults().set("135", forKey: "Pitching Wedge")
    UserDefaults().set("145", forKey: "9 Iron")
    UserDefaults().set("155", forKey: "8 Iron")
    UserDefaults().set("165", forKey: "7 Iron")
    UserDefaults().set("175", forKey: "6 Iron")
    UserDefaults().set("185", forKey: "5 Iron")
}

func checkDefaults(clubsArray: [String]) {
    for club in clubsArray {
        let dist = UserDefaults().value(forKey: club)
        print("\(club) has key/distance of \(dist ?? "ERROR GETTING DISTANCE")")
    }
}

func pickClubFromDistance(_ clubs: [String], distance: Int) -> String {
    var pickedClub: String = ""
    var smallestDifference: Int = 999
    for club in clubs {
        if let thisClubDistance = Int(getDistanceForOneClub(forThisClub: club)) {
            let thisDiff = abs(thisClubDistance - distance)
            print("The distance between \(distance) and \(club)'s club distance of \(thisClubDistance) is \(thisDiff)")
            if thisDiff < smallestDifference {
                pickedClub = club
                smallestDifference = thisDiff
            }
        }
    }
    return pickedClub
}

func printBagOutLines(bag: UserBag) {
    for item in bag.allClubs2DArray {
        for item2 in item {
            print(item2)
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

func saveCurrentClub() {
    for clubTypeIndex in 0 ..< mainBag.allClubs2DArray.count {
        for clubIndex in 0 ..< mainBag.allClubs2DArray[clubTypeIndex].count {
            let club = mainBag.allClubs2DArray[clubTypeIndex][clubIndex]
            if club == currentClub {
                mainBag.allClubs2DArray[clubTypeIndex][clubIndex] = currentClub
                doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
            }
        }
    }
}

// TODO: - Make this work for different type of hits
func deleteFromCurrentClubPrevHits(thisIndex index: Int, from swingType: swingTypeState) {
    var arrFromStr = currentClub.previousFullHits.components(separatedBy: ",")
    if index < arrFromStr.count {
        arrFromStr.remove(at: index)
    }
    currentClub.previousFullHits = arrFromStr.joined(separator: ",")
    currentClub.averageFullDistance = getAvgFromStr(currentClub.previousFullHits)
    saveCurrentClub()
}

func getAvgFromStr(_ str: String) -> Int {
    var sum = 0
    let arrFromStr = str.components(separatedBy: ",")
    var numItemsCount = 0
    for item in arrFromStr {
        if let strInt = Int(item) {
            numItemsCount += 1
            sum += strInt
        }
    }
    if numItemsCount != 0 {
        return Int(sum / numItemsCount)
    } else {
        return 0
    }
}

func removeEmptyFromPrevHits() {
    var prevHitsStr = currentClub.previousFullHits
    if prevHitsStr.last == "," {
        _ = prevHitsStr.removeLast()
    }
    currentClub.previousFullHits = prevHitsStr
    saveCurrentClub()
}
