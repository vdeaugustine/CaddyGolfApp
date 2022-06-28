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

}
