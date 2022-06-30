//
//  Objects.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

enum ClubType: String, Codable, CaseIterable, Hashable {
    case wood, hybrid, iron, wedge
}

enum SwingDirection: String, Codable, CaseIterable {
    case left, right, straight
}
