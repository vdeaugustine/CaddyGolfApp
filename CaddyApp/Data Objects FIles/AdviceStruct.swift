//
//  AdviceStruct.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

struct Advice {
    var closestClub: SingleClub {
        didSet {
            self.updateClosestClubGap()
        }
    }

    var closestClubDistance: Int = 0
    var closestClubGap: Int = 0
    var secondclosestClub: SingleClub
    var secondclosestClubDistance: Int = 0
    var secondClosestClubGap: Int = 0

    var distanceToPin = 0
    
    mutating func updateClosestClubGap() {
        print("calling updateClosestClubGap")
        closestClubGap = abs(Int(closestClub.fullSwingDistance) - distanceToPin)

    }
}
