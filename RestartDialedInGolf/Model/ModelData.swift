//
//  ModelData.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import AVFAudio
import Foundation

enum modelDataType { case regular, preview }

enum SaveItemError: String, Error {
    case cannotFindInBag, cannotRemove
}

enum bagEnum: String { case bag }

class ModelData: ObservableObject {
    @Published var bag: Bag = Bag()

    func insertNote(_ thisNote: Note) {
        bag.notes.append(thisNote)
        saveBag()
    }
    
    func makeDefault(forType: modelDataType = .regular) {
        self.bag.clubs.removeAll()
        // default woods
        // driver
//        clubs.insert(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        self.bag.clubs.append(Club(number: "Driver", type: .wood, name: "Driver", distance: 250))
        self.bag.clubs.append(Club(number: "3", type: .wood, name: "3 " + ClubType.wood.rawValue, distance: 220))
        self.bag.clubs.append(Club(number: "5", type: .wood, name: "5 " + ClubType.wood.rawValue, distance: 200))

        // default hybrid
        self.bag.clubs.append(Club(number: "4", type: .hybrid, name: "4 " + ClubType.hybrid.rawValue, distance: 215))

        // default irons
        for n in 5 ... 9 {
            self.bag.clubs.append(Club(number: "\(n)", type: .iron, name: "\(n) " + ClubType.iron.rawValue, distance: 185 - Int(n * 5)))
        }
        // default wedges
        self.bag.clubs.append(Club(number: "P", type: .wedge, name: "P " + ClubType.wedge.rawValue, distance: 135))
        self.bag.clubs.append(Club(number: "60", type: .wedge, name: "60 " + ClubType.wedge.rawValue, distance: 60))
        self.bag.clubs.append(Club(number: "56", type: .wedge, name: "56 " + ClubType.wedge.rawValue, distance: 80))

        self.saveBag()
        
        
        // Give all the clubs some swings so they have something to work with
        if forType == .preview {
            for index in 0 ..< self.bag.clubs.count {
                let numSwings = Int.random(in: 15 ... 60)
                for _ in 1 ... numSwings {
                    let green = Bool.random()
                    let hit = Bool.random()
                    if green {
                        self.bag.clubs[index].addSwing(Swing(distance: Int.random(in: 100 ... 210),
                                                   direction: SwingDirection.allCases.randomElement()!,
                                                   hitGreen: hit,
                                                   attemptingGreen: true))
                    } else {
                        self.bag.clubs[index].addSwing(Swing(distance: Int.random(in: 100 ... 210),
                                                   direction: SwingDirection.allCases.randomElement()!,
                                                   hitFairway: hit,
                                                   attemptingFairway: true))
                    }
                }
                
            }
        }
    }

    func deleteClub(_ club: Club) throws {
        enum DeleteError: Error { case failedToDelete, couldntFindClubIndex, foundIndexOutOfRange }
        guard let removeIndex = bag.clubs.firstIndex(where: { $0 == club }) else {
            throw DeleteError.couldntFindClubIndex
        }
        guard removeIndex < bag.clubs.count else {
            throw DeleteError.foundIndexOutOfRange
        }
        bag.clubs.remove(at: removeIndex)
        saveBag()
    }

    /// - Parameters:
    ///   - thisNote: the note that we will update. It should still be un-updated when it is passed as parameter
    /// - Returns: true if the note updated successfully
    func updateNote(_ thisNote: Note, newTitle: String? = nil, newBody: String? = nil) -> Bool {
        guard let ind = bag.notes.firstIndex(of: thisNote) else {
            print("error in update note index")
            return false
        }

        if let newTitle = newTitle {
            bag.notes[ind].title = newTitle
        }
        if let newBody = newBody {
            bag.notes[ind].body = newBody
        }

        bag.notes[ind].date = Date()

        saveBag()

        return true
    }

    func saveBag() {
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(bag)
            UserDefaults.standard.set(data, forKey: bagEnum.bag.rawValue)
        } catch {
            print(error)
        }
    }

    func addStrokeToClub(stroke: Swing, club: Club) throws {
        guard let clubInBagIndex = bag.clubs.firstIndex(of: club) else {
            throw SaveItemError.cannotFindInBag
        }

        bag.clubs[clubInBagIndex].addSwing(stroke)

        saveBag()
    }

    func addClub(_ club: Club) throws {
        enum AddClubErrors: Error { case clubAlreadyExists }
        if bag.clubs.contains(where: { $0 == club }) {
            throw AddClubErrors.clubAlreadyExists
        }
        bag.clubs.append(club)
    }

    func loadBag() -> Bag? {
        var retBag: Bag?
        if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
            do {
                let decoder = JSONDecoder()
                let thisBag = try decoder.decode(Bag.self, from: existingBag)
                retBag = thisBag
                print(thisBag)
            } catch { print(error) }
        }
        return retBag
    }

    init(forType: modelDataType) {
        switch forType {
        case .regular:
            guard let existingBag = loadBag() else { print("no bag found"); return }
            bag = existingBag
            saveBag()
        case .preview:
            self.makeDefault(forType: .preview)
        }
    }
}
