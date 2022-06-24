//
//  Swing.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

struct Swing: Codable, Hashable, Equatable, CustomStringConvertible {
    var distance: Int
    var direction: SwingDirection
    var date: Date
    var hitFairway: Bool
    var hitGreen: Bool
    var wasGoingForGreen: Bool
    var wasGoingForFairway: Bool
    


    var FIRSuccess: Bool {
        return wasGoingForFairway && hitFairway
    }

    var GIRSuccess: Bool {
        return wasGoingForGreen && hitGreen
    }

    var description: String {
        return "Distance:\(distance), Direction: \(direction), Date\(date)"
    }

    init(distance: Int, direction: SwingDirection, date: Date = Date(), hitFairway: Bool = false, hitGreen: Bool = false, attemptingGreen: Bool = false, attemptingFairway: Bool = false) {
        self.distance = distance
        self.direction = direction
        self.date = date
        self.hitFairway = hitFairway
        self.hitGreen = hitGreen
        self.wasGoingForGreen = attemptingGreen
        self.wasGoingForFairway = attemptingFairway
    }

    static func == (lhs: Swing, rhs: Swing) -> Bool {
        let condition1 = lhs.distance == rhs.distance
        let condition2 = lhs.direction == rhs.direction
        let condition3 = lhs.date == rhs.date
        return condition1 && condition2 && condition3
    }
}
