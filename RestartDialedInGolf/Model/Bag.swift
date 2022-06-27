//
//  Bag.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

struct Note: Codable, Equatable, Identifiable, CustomStringConvertible, Hashable {
    var title: String
    var body: String
    var date: Date
    var id = UUID()

    var description: String {
        return "Title: \(title)\nBody: \(body)\nDate: \(date)\nID:\(id)"
    }

    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.body == rhs.body && lhs.title == rhs.title && lhs.date == rhs.date
    }
}

struct Bag: Codable {
    var clubs = [Club]()
    var notes = [Note]()
    var reload = 0

    var clubsArray: [Club] {
        return Array(clubs).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    enum CodingKeys: CodingKey {
        case clubs, notes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        clubs = try container.decode([Club].self, forKey: .clubs)
        notes = try container.decode([Note].self, forKey: .notes)
    }
    init(){}

//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        clubs = try container.decode(Set<Club>.self, forKey: .clubs)
//        notes = try container.decode(Set<Note>.self, forKey: .notes)
//    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(clubs, forKey: .clubs)
        try container.encode(notes, forKey: .notes)
    }
    
    mutating func editClubDistance(_ newDistance: Int, forClub: Club) throws {
        enum editClubErrors: Error { case cantFindClub, clubsIndexOutOfRange }
        guard let thisClubsIndex = self.clubs.firstIndex(where: {$0 == forClub}) else {
            throw editClubErrors.cantFindClub
        }
        
        guard thisClubsIndex < clubs.count else {
            throw editClubErrors.clubsIndexOutOfRange
        }
        
        var thisClub = self.clubs.remove(at: thisClubsIndex)
        thisClub.setDistance(newDistance)
        if thisClubsIndex > clubs.count { clubs.append(thisClub) }
        else { self.clubs.insert(thisClub, at: thisClubsIndex) }
        
    }

    var woods: [Club] {
        let filtered = clubs.filter({ $0.getType() == .wood })
        return Array(filtered).sorted(by: { $0.getDistance() > $1.getDistance() })
    }

    func getArray(of clubType: ClubType) -> [Club] {
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

    mutating func makeDefault(forType: modelDataType = .regular, modelData: ModelData) {
        clubs.removeAll()
        // default woods
        // driver
//        clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        clubs.append(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        clubs.append(Club(number: "3", type: .wood, name: "3 " + ClubType.wood.rawValue, distance: 220))
        clubs.append(Club(number: "5", type: .wood, name: "5 " + ClubType.wood.rawValue, distance: 200))

        // default hybrid
        clubs.append(Club(number: "4", type: .hybrid, name: "4 " + ClubType.hybrid.rawValue, distance: 215))

        // default irons
        for n in 5 ... 9 {
            clubs.append(Club(number: "\(n)", type: .iron, name: "\(n) " + ClubType.iron.rawValue, distance: 185 - Int(n * 5)))
        }
        // default wedges
        clubs.append(Club(number: "P", type: .wedge, name: "P " + ClubType.wedge.rawValue, distance: 135))
        clubs.append(Club(number: "60", type: .wedge, name: "60 " + ClubType.wedge.rawValue, distance: 60))
        clubs.append(Club(number: "56", type: .wedge, name: "56 " + ClubType.wedge.rawValue, distance: 80))

        modelData.saveBag()
        
        
        // Give all the clubs some swings so they have something to work with
        if forType == .preview {
            for index in 0 ..< clubs.count {
                let numSwings = Int.random(in: 15 ... 60)
                for _ in 1 ... numSwings {
                    let green = Bool.random()
                    let hit = Bool.random()
                    if green {
                        clubs[index].addSwing(Swing(distance: Int.random(in: 100 ... 210),
                                                   direction: SwingDirection.allCases.randomElement()!,
                                                   hitGreen: hit,
                                                   attemptingGreen: true))
                    } else {
                        clubs[index].addSwing(Swing(distance: Int.random(in: 100 ... 210),
                                                   direction: SwingDirection.allCases.randomElement()!,
                                                   hitFairway: hit,
                                                   attemptingFairway: true))
                    }
                }
                
            }
        }
    }
}
