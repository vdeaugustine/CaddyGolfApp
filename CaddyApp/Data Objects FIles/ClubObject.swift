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
    var averageDistance: Int = 0
    var description: String {
        return "\(name)-\(fullDistance)".uppercased()
    }
    
    var previousHits : String

    public static func == (lhs: ClubObject, rhs: ClubObject) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
