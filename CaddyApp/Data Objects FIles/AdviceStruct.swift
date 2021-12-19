//
//  AdviceStruct.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

struct Advice {
    var closestClub: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageDistance: 0, previousHits: "")
    
    var closestClubDistance: Int = 0
    var closestClubGap: Int = 0
    var secondclosestClub: ClubObject = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0, averageDistance: 0, previousHits: "")
    var secondclosestClubDistance: Int = 0
    var secondClosestClubGap: Int = 0
    
    var distanceToPin = 0
    
}
