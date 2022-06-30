//
//  Enums.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import Foundation

enum TypeOfShot: String, CaseIterable, Codable {
    case teeshot = "From the Tee Box"
    case fairwayShot = "From the Fairway"
    case approach = "Approach"
}

enum FlagColors: String, CaseIterable {
    case red, white, blue
}

enum BallPositions: String, CaseIterable, Codable {
    case flat, downhill, uphill
    case belowFeet = "Ball Below Feet"
    case aboveFeet = "Ball Above Feet"
}
