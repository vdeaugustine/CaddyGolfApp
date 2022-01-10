//
//  ManagePreviousSwings.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/2/22.
//

import Foundation
import UIKit

func addSwing(typeOfSwing: swingTypeState, distance: Int) {
    switch typeOfSwing {
    case .fullSwing:
        currentClub.previousFullHits.append("\(distance),")
        currentClub.averageFullDistance = getAvgFromStr(currentClub.previousFullHits)
        currentClub.allPreviousSwings.append("\(distance),")
        currentClub.allPreviousSwingTypes.append("\(swingTypeState.fullSwing.rawValue),")
    case .maxSwing:
        currentClub.previousMaxHits.append("\(distance),")
        currentClub.averageMaxDistance = getAvgFromStr(currentClub.previousMaxHits)
        currentClub.allPreviousSwings.append("\(distance),")
        currentClub.allPreviousSwingTypes.append("\(swingTypeState.maxSwing.rawValue),")
    case .threeFourths:
        currentClub.previousThreeFourthsHits.append("\(distance),")
        currentClub.averageThreeFourthsDistance = getAvgFromStr(currentClub.previousThreeFourthsHits)
        currentClub.allPreviousSwings.append("\(distance),")
        currentClub.allPreviousSwingTypes.append("\(swingTypeState.threeFourths.rawValue),")
    }
    saveCurrentClub()
}

/// Used to get list of swings this club has saved
/// - Parameter typeOfSwing: just the type of swing using endum (ex: .fullSwing)
/// - Returns: an array of strings. each item will be an individual swing
func getSwings(typeOfSwing: swingTypeState) -> [String] {
    var returnItem = [String]()

    switch typeOfSwing {
    case .fullSwing:
        returnItem = currentClub.previousFullHits.components(separatedBy: ",")
    case .maxSwing:
        returnItem = currentClub.previousMaxHits.components(separatedBy: ",")
    case .threeFourths:
        returnItem = currentClub.previousThreeFourthsHits.components(separatedBy: ",")
    }

    return returnItem
}
