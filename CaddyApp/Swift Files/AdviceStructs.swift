//
//  AdviceStruct.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

struct Advice {
    var closestClubBelow: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageFullDistance: 0, previousFullHits: "")

    var clubBelowDistance: Int = 0
    var clubBelowGap: Int = 0
    var clubAboveGap: Int = 0
    var clubAboveDistance: Int = 0
    var closestClubAbove: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageFullDistance: 0, previousFullHits: "")
    var secondclosestClubDistance: Int = 0
    var secondClosestClubGap: Int = 0
    var flagColor: String = "Red"

    var lieType: String = "SideHillDown"

    var distanceToPin = 0

    func getExactClubForFlag() -> ClubObject {
        var newDistance = distanceToPin
        switch flagColor {
        case "Red":
            newDistance = distanceToPin + 10
        case "White":
            newDistance = distanceToPin
        case "Blue":
            newDistance = distanceToPin - 10
        default:
            break
        }

        var shortestClubGap = 999
        var closestClub = currentClub
        for clubType in mainBag.allClubs2DArray {
            for club in clubType {
                let thisClubGap = abs(newDistance - club.fullDistance)
                if thisClubGap < shortestClubGap {
                    shortestClubGap = thisClubGap
                    closestClub = club
                }
            }
        }

        return closestClub
    }
}

struct ClosestClubBelow {
    var gap = 999
    var clubName = ""
    var swingType: swingTypeState
}
