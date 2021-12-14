//
//  SaveBag.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/13/21.
//

import Foundation

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"

    var errorDescription: String? {
        rawValue
    }
}

protocol ObjectSavable {
    /// setObject method accepts an object whose type conforms to Encodable protocol and a key that we want to associate with it.

    func setCustomObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable

    /// getObject method accepts a key by which we will retrieve the associated object from UserDefaults and a type that conforms to the Decodable protocol. Note that to pass a type itself we have used Metatype😕.
    func getCustomObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

extension UserDefaults: ObjectSavable {
    func setCustomObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }

    func getCustomObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}



func doSave(userDefaults: UserDefaults, saveThisBag: UserBag) {
    do {
        try userDefaults.setCustomObject(saveThisBag, forKey: "user_bag")
    } catch {
        print(error.localizedDescription)
    }
}
