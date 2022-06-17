//
//  Bag.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation



class Bag: ObservableObject, Codable {
//    @Published var clubs = Set<Club>()
    var clubs = Set<Club>()
    
    var clubsArray: [Club] {
        return Array(clubs).sorted(by: {$0.getDistance() > $1.getDistance()})
    }
    
    
    enum CodingKeys: CodingKey {
        case clubs
    }
    
    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clubs = try container.decode(Set<Club>.self, forKey: .clubs)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(clubs, forKey: .clubs)
    }

    var woods: Set<Club> {
        let filtered = clubs.filter({ $0.getType() == .wood })
        return filtered
    }

    var irons: Set<Club> {
        let filtered = clubs.filter({ $0.getType() == .iron })
        return filtered
    }

    var hybrids: Set<Club> {
        let filtered = clubs.filter({ $0.getType() == .hybrid })
        return filtered
    }

    var wedges: Set<Club> {
        let filtered = clubs.filter({ $0.getType() == .wedge })
        return filtered
    }
    
    
    func makeDefault() {
        self.clubs = Set<Club>()
        // default woods
        // driver
//        clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        self.clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        self.clubs.insert(Club(number: "3", type: .wood, name: "3 " + ClubType.wood.rawValue, distance: 220))
        self.clubs.insert(Club(number: "5", type: .wood, name: "5 " + ClubType.wood.rawValue, distance: 200))
        
        // default hybrid
        self.clubs.insert(Club(number: "4", type: .hybrid, name: "4 " + ClubType.hybrid.rawValue, distance: 215))
        
        // default irons
        for n in 5...9 {
            self.clubs.insert(Club(number: "\(n)", type: .iron, name: "\(n) " + ClubType.iron.rawValue, distance: 185 - Int(n * 5)))
        }
        // default wedges
        self.clubs.insert(Club(number: "P", type: .wedge, name: "P " + ClubType.wedge.rawValue, distance: 135))
        self.clubs.insert(Club(number: "60", type: .wedge, name: "60 " + ClubType.wedge.rawValue, distance: 60))
        self.clubs.insert(Club(number: "56", type: .wedge, name: "56 " + ClubType.wedge.rawValue, distance: 80))
        
        print("Bag is now")
        for club in clubs {
            print(club)
        }
    }
    
    
}
