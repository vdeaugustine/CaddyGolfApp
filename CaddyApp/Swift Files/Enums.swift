//
//  Enums.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

enum settingsKeys: String {
    case useMeters
    case showThisSwingTypeByDefault = "swingTypeDefault"
}

enum AllClubNames: String, CaseIterable {
    case nineIron = "9 Iron"
    case eightIron = "8 Iron"
    case sevenIron = "7 Iron"
    case sixIron = "6 Iron"
    case fiveIron = "5 Iron"
    case fourIron = "4 Iron"
    case threeIron = "3 Iron"
    case twoIron = "2 Iron"
    case oneIron = "1 Iron"

    case driver = "Driver"
    case fiveWood = "5 Wood"
    case fourWood = "4 Wood"
    case threeWood = "3 Wood"
    case twoWood = "2 Wood"

    case fiveHybrid = "5 Hybrid"
    case fourHybrid = "4 Hybrid"
    case threeHybrid = "3 Hybrid"
    case twoHybrid = "2 Hybrid"
    case oneHybrid = "1 Hybrid"

    case wedge60 = "60 Wedge"
    case wedge58 = "58 Wedge"
    case wedge56 = "56 Wedge"
    case wedge54 = "54 Wedge"
    case wedge52 = "52 Wedge"
    case wedge48 = "48 Wedge"
    case pitchingWedge = "P Wedge"
}

enum standardDistanceForClub: Int {
    case nineIron = 145
    case eightIron = 155
    case sevenIron = 165
    case sixIron = 175
    case fiveIron = 185
    case fourIron = 195
    case threeIron = 205
    case twoIron = 215
    case oneIron = 225

    case fiveHybrid = 200
    case fourHybrid = 210
    case threeHybrid = 220
    case twoHybrid = 230
    case oneHybrid = 250

    case driver = 275
    case twoWood = 265
    case threeWood = 255
    case fourWood = 245
    case fiveWood = 235

    case wedge48 = 125
    case wedge52 = 110
    case wedge54 = 100
    case wedge56 = 85
    case wedge58 = 70
    case wedge60 = 60

    case pitchingWedge = 135
}

enum standardIronLengths: Int, CaseIterable {
    case nineIron = 145
    case eightIron = 155
    case sevenIron = 165
    case sixIron = 175
    case fiveIron = 185
    case fourIron = 195
    case threeIron = 205
    case twoIron = 215
    case oneIron = 225
}

enum standardWoodsLengths: Int {
    case driver = 275
    case twoWood = 265
    case threeWood = 255
    case fourWood = 245
    case fiveWood = 235
}

enum standardHybridLengths: Int {
    case fiveHybrid = 200
    case fourHybrid = 210
    case threeHybrid = 220
    case twoHybrid = 230
    case oneHybrid = 250
}

enum standardWedgeLengths: Int {
    case wedge48 = 125
    case wedge52 = 110
    case wedge54 = 100
    case wedge56 = 85
    case wedge58 = 70
    case wedge60 = 60
}

enum ironTypes: String, CaseIterable {
    case nineIron = "9 Iron"
    case eightIron = "8 Iron"
    case sevenIron = "7 Iron"
    case sixIron = "6 Iron"
    case fiveIron = "5 Iron"
    case fourIron = "4 Iron"
    case threeIron = "3 Iron"
    case twoIron = "2 Iron"
    case oneIron = "1 Iron"
}

enum woodTypes: String, CaseIterable {
    case driver = "Driver"
    case fiveWood = "5 Wood"
    case fourWood = "4 Wood"
    case threeWood = "3 Wood"
    case twoWood = "2 Wood"
}

enum hybridTypes: String, CaseIterable {
    case fiveHybrid = "5 Hybrid"
    case fourHybrid = "4 Hybrid"
    case threeHybrid = "3 Hybrid"
    case twoHybrid = "2 Hybrid"
    case oneHybrid = "1 Hybrid"
}

enum wedgesTypes: String, CaseIterable {
    case wedge60 = "60 Wedge"
    case wedge58 = "58 Wedge"
    case wedge56 = "56 Wedge"
    case wedge54 = "54 Wedge"
    case wedge52 = "52 Wedge"
    case wedge48 = "48 Wedge"
    case pitching = "Pitching"
}

enum clubTypesEnum: String, CaseIterable {
    case irons = "Iron"
    case woods = "Wood"
    case wedges = "Wedge"
    case hybrids = "Hybrid"
}

enum swingTypeState: String, CaseIterable {
    case fullSwing = "Full Swing"
    case maxSwing = "Max Swing"
    case threeFourths = "Three Fourths"
}

enum lieTypes: String {
    case sideHillDown = "SideHillDown"
    case upHill = "UpHill"
    case downHill = "DownHill"
    case sideHillUp = "SideHillUp"
}

enum ConstraintTypes: CaseIterable {
    case topAnchor
    case bottomAnchor
    case leadingAnchor
    case trailingAnchor
    case centerX
    case centerY
}
