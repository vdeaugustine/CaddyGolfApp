//
//  load.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import Foundation


func loadBag() -> Bag? {
    var retBag: Bag?
    if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
        do {
            let decoder = JSONDecoder()
            let thisBag = try decoder.decode(Bag.self, from: existingBag)
            retBag = thisBag
        } catch {
            print(error)
        }
    }
    return retBag
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

