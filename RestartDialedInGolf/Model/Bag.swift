//
//  Bag.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

class Bag: ObservableObject, Codable {
//    @Published var clubs = Set<Club>()
    @Published var clubs = Set<Club>()

    var clubsArray: [Club] {
        return Array(clubs).sorted(by: { $0.getDistance() > $1.getDistance() })
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

    var woods: [Club] {
        let filtered = clubs.filter({ $0.getType() == .wood })
        return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    func getArray(of clubType: ClubType) -> [Club] {
        print("calling get array")
        switch clubType {
        case .wood:
            let filtered = clubs.filter({ $0.getType() == .wood })
            return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
        case .hybrid:
            let filtered = clubs.filter({ $0.getType() == .hybrid })
            return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
        case .iron:
            let filtered = clubs.filter({ $0.getType() == .iron })
            return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
        case .wedge:
            let filtered = clubs.filter({ $0.getType() == .wedge })
            return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
        }
    }

    var irons: [Club] {
        let filtered = clubs.filter({ $0.getType() == .iron })
        return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    var hybrids: [Club] {
        let filtered = clubs.filter({ $0.getType() == .hybrid })
        return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    var wedges: [Club] {
        let filtered = clubs.filter({ $0.getType() == .wedge })
        return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    func makeDefault(forType: modelDataType = .regular) {
        clubs = Set<Club>()
        // default woods
        // driver
//        clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        clubs.insert(Club(number: "3", type: .wood, name: "3 " + ClubType.wood.rawValue, distance: 220))
        clubs.insert(Club(number: "5", type: .wood, name: "5 " + ClubType.wood.rawValue, distance: 200))

        // default hybrid
        clubs.insert(Club(number: "4", type: .hybrid, name: "4 " + ClubType.hybrid.rawValue, distance: 215))

        // default irons
        for n in 5 ... 9 {
            clubs.insert(Club(number: "\(n)", type: .iron, name: "\(n) " + ClubType.iron.rawValue, distance: 185 - Int(n * 5)))
        }
        // default wedges
        clubs.insert(Club(number: "P", type: .wedge, name: "P " + ClubType.wedge.rawValue, distance: 135))
        clubs.insert(Club(number: "60", type: .wedge, name: "60 " + ClubType.wedge.rawValue, distance: 60))
        clubs.insert(Club(number: "56", type: .wedge, name: "56 " + ClubType.wedge.rawValue, distance: 80))

        print("Bag is now")
        for club in clubs {
            print(club)
        }

        // Give all the clubs some swings so they have something to work with
        if forType == .preview {
            for thisClub in clubs {
                var workingClub = thisClub
                clubs.remove(thisClub)
                let numSwings = Int.random(in: 15 ... 60)
                for _ in 1 ... numSwings {
                    workingClub.addSwing(Swing(distance: Int.random(in: 100 ... 210),
                                               direction: SwingDirection.allCases.randomElement()!))
                }
                clubs.insert(workingClub)
            }
        }
    }
}
