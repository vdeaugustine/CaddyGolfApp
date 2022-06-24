//
//  ModelData.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import AVFAudio
import Foundation

enum modelDataType {
    case regular, preview
}

enum SaveItemError: String, Error {
    case cannotFindInBag
    case cannotRemove
}

enum bagEnum: String {
    case bag
}

class ModelData: ObservableObject {
    @Published var bag: Bag = Bag()
    
    func insertNote(_ thisNote: Note) {
        bag.notes.insert(thisNote)
        saveBag()
    }

    /// - Parameters:
    ///   - thisNote: the note that we will update. It should still be un-updated when it is passed as parameter
    /// - Returns: true if the note updated successfully
    func updateNote(_ thisNote: Note, newTitle: String? = nil, newBody: String? = nil) -> Bool {
        var retVal = false
        guard var noteFoundInNotes = bag.notes.remove(thisNote) else { return false }
        if let newTitle = newTitle {
            noteFoundInNotes.title = newTitle
        }
        if let newBody = newBody {
            noteFoundInNotes.body = newBody
        }

        noteFoundInNotes.date = Date()

        retVal = bag.notes.insert(noteFoundInNotes).0

        saveBag()

        return retVal
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
        

        var clubInBag = bag.clubs.remove(at: clubInBagIndex)
        clubInBag.addSwing(stroke)
        bag.clubs.insert(clubInBag)

        saveBag()
    }

    func loadBag() -> Bag? {
        var retBag: Bag?
        if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
            do {
                let decoder = JSONDecoder()
                let thisBag = try decoder.decode(Bag.self, from: existingBag)
                retBag = thisBag
                print(thisBag)
            } catch {
                fatalError("Couldn't parse bag as Bag :\n\(error)")
            }
        }
        return retBag
    }

    init(forType: modelDataType) {
        switch forType {
        case .regular:
            if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
                do {
                    let decoder = JSONDecoder()
                    let thisBag = try decoder.decode(Bag.self, from: existingBag)
                    bag = thisBag

                } catch {
                    fatalError("Couldn't parse bag as Bag :\n\(error)")
                }
                return
            }
            print("no bag found")
            bag.makeDefault()
            saveBag()
        case .preview:
            bag.makeDefault(forType: .preview)
        }
    }
}
