//
//  SomeFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import Foundation
import UIKit

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
