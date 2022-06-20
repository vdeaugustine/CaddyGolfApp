//
//  ModelData.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

enum modelDataType {
    case regular, preview
}

enum SaveItemError: String, Error {
    case cannotFindInBag
    case cannotRemove
}

class ModelData: ObservableObject {
    @Published var bag: Bag = Bag()

    func saveBag() {
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(bag)
            UserDefaults.standard.set(data, forKey: "bag")

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
        if let existingBag = UserDefaults.standard.object(forKey: "bag") as? Data {
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
        case .preview:
            if let existingBag = UserDefaults.standard.object(forKey: "bag") as? Data {
                do {
                    let decoder = JSONDecoder()
                    let thisBag = try decoder.decode(Bag.self, from: existingBag)
                    bag = thisBag
                    print(thisBag)
                } catch {
                    fatalError("Couldn't parse bag as Bag :\n\(error)")
                }
                return
            }
            print("no bag found")
            bag.makeDefault()
            saveBag()
        case .regular:
            bag.makeDefault(forType: .preview)
        }
    }
}
