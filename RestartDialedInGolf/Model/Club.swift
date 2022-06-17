//
//  Club.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

struct Club: Codable, Hashable, Equatable, CustomStringConvertible {
    var description: String {
        return name
    }

    init(number: String, type: ClubType, name: String, distance: Int) {
        self.number = number
        self.type = type
        self.name = name
        self.distance = distance
    }
    
    private var number: String
    private var type: ClubType
    private var name: String
    private var distance: Int
    private var swings: [Swing] = [Swing]()
    func getNumber() -> String {
        return number
    }
    func getName() -> String {
        return name
    }
    func getType() -> ClubType {
        return type
    }
    func getDistance() -> Int {
        return distance
    }
    func getSwings(ofType: SwingDirection? = nil) -> [Swing] {
        if let ofType = ofType {
            return swings.filter({$0.direction == ofType})
        }
        return swings
    }
    
    mutating func setNumber(_ n: String) {
        self.number = n
    }
    mutating func setName(_ n: String) {
        self.name = n
    }
    mutating func setType(_ n: ClubType) {
        self.type = n
    }
    mutating func setDistance(_ n: Int) {
        self.distance = n
    }
    mutating func setSwings(_ swings: [Swing]) {
        self.swings = swings
    }
    mutating func addSwing(_ swing: Swing) {
        self.swings.append(swing)
    }
    mutating func deleteSwing(_ swing: Swing) {
        self.swings.append(swing)
    }

    static func == (lhs: Club, rhs: Club) -> Bool {
        return lhs.number == rhs.number && lhs.type == rhs.type
    }
}
