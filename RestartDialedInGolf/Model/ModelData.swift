//
//  ModelData.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation

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
    
    
    init() {
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
    }
}
