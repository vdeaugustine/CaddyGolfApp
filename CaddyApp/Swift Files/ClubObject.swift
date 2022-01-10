//
//  ClubObject.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/17/21.
//

import Foundation

struct ClubObject: Codable, CustomStringConvertible, Equatable {
    var name: String
    var type: String
    var fullDistance: Int
    var threeFourthsDistance: Int
    var maxDistance: Int
    var averageFullDistance: Int = 0
    var averageMaxDistance: Int = 0
    var averageThreeFourthsDistance: Int = 0
    var description: String {
        return "\(name)-\(fullDistance)".uppercased()
    }

    var previousFullHits: String = ""
    var previousThreeFourthsHits: String = ""
    var previousMaxHits: String = ""
    var allNotes = [String]()

    var allPreviousSwings: String = ""
    var allPreviousSwingTypes: String = ""
    var mostRecentClubNoteTitle: String = "No notes yet"

    public static func == (lhs: ClubObject, rhs: ClubObject) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
