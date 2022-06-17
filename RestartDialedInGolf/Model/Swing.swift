//
//  Swing.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

struct Swing: Codable, Hashable, Equatable {
    var distance: Int
    var direction: SwingDirection
    var date: Date
    
    static func == (lhs: Swing, rhs: Swing) -> Bool {
        let condition1 = lhs.distance == rhs.distance
        let condition2 = lhs.direction == rhs.direction
        let condition3 = lhs.date == rhs.date
        return condition1 && condition2 && condition3
    }
}
