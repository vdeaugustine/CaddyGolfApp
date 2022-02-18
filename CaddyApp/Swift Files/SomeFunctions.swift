//
//  SomeFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import AVFoundation
import CloudKit
import Foundation
import UIKit

func playSound(whichSound: String) {
    var thisURL: URL
    var fileType: AVFileType
    var methodStart = Date()

    /* ... Do whatever you need to do ... */
    var methodInterval = Date()
    switch whichSound {
    case "Swing":
        
        guard let url = Bundle.main.url(forResource: "golfhit", withExtension: "wav") else {
            fatalError()
        }
        methodInterval = Date()
        print("get url resource", methodInterval.timeIntervalSince(methodStart))
        methodStart = Date()
        
        thisURL = url
        fileType = .wav
    case "Scribble":
        guard let url = Bundle.main.url(forResource: "scribble", withExtension: "mp3") else {
            fatalError()
        }
        thisURL = url
        fileType = .mp3
    default:
        fatalError()
    }

    do {
        
        

        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        
        audioPlayer = try AVAudioPlayer(contentsOf: thisURL, fileTypeHint: fileType.rawValue)
        methodInterval = Date()
        print("contents of", methodInterval.timeIntervalSince(methodStart))
        methodStart = Date()
        /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

        
        guard let player = audioPlayer else {
            fatalError()
        }

        
        player.play()
        methodInterval = Date()
        print("play",methodInterval.timeIntervalSince(methodStart))
        methodStart = Date()
        

    } catch let error {
        print(error.localizedDescription)
        fatalError()
    }
}

func getHighestClub() -> ClubObject {
    var highestClub = ClubObject(name: "", type: "", fullDistance: 0, threeFourthsDistance: 0, maxDistance: 0)
    for clubType in mainBag.allClubs2DArray {
        for club in clubType {
            if club.fullDistance >= highestClub.fullDistance {
                highestClub = club
            }
        }
    }
    return highestClub
}

func getLowestClub() -> ClubObject {
    var lowestClub = ClubObject(name: "", type: "", fullDistance: 999, threeFourthsDistance: 999, maxDistance: 999)
    for clubType in mainBag.allClubs2DArray {
        for club in clubType {
            if club.fullDistance <= lowestClub.fullDistance {
                lowestClub = club
            }
        }
    }
    return lowestClub
}

func getMetersOrYards(_ passedYards: Int) -> Int {
    if useMeters {
        let multFactor = 1.09361
        return Int(round(multFactor * Double(passedYards)))

    } else {
        return passedYards
    }
}

func setUpSettings() {
    let defaults = UserDefaults()
    useMeters = defaults.bool(forKey: "useMeters")
}

func currentClubTypeAsEnum() -> AllClubNames {
    switch currentClub.name.capitalized {
    case "9 Iron":
        return .nineIron
    case "8 Iron":
        return .eightIron
    case "7 Iron":
        return .sevenIron
    case "6 Iron":
        return .sixIron
    case "5 Iron":
        return .fiveIron
    case "4 Iron":
        return .fourIron
    case "3 Iron":
        return .threeIron
    case "2 Iron":
        return .twoIron
    case "1 Iron":
        return .oneIron

    case "Driver":
        return .driver
    case "5 Wood":
        return .fiveWood
    case "4 Wood":
        return .fourWood
    case "3 Wood":
        return .threeWood
    case "2 Wood":
        return .twoWood

    case "5 Hybrid":
        return .fiveHybrid
    case "4 Hybrid":
        return .fourHybrid
    case "3 Hybrid":
        return .threeHybrid
    case "2 Hybrid":
        return .twoHybrid
    case "1 Hybrid":
        return .oneHybrid

    case "60 Wedge":
        return .wedge60
    case "58 Wedge":
        return .wedge58
    case "56 Wedge":
        return .wedge56
    case "54 Wedge":
        return .wedge54
    case "52 Wedge":
        return .wedge52
    case "48 Wedge":
        return .wedge48
    case "P Wedge":
        return .pitchingWedge

    default:
        print("Got", currentClub.name, "which is not a case")
        fatalError()
    }
}

func delay(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

func getAllDistances(forTheseClubs clubs: [String]) -> [Int] {
    var distances = [Int]()
    for clubType in clubs {
        if let dis = UserDefaults().value(forKey: "\(clubType)") {
            // Hacky way to get the UserDefaults values to ints to be returned
            let disStr = "\(dis)"
            if let disInt = Int(disStr) {
                distances.append(disInt)
            }
        } else {
            print("\(clubType) does not have any value set yet")
        }
    }
    return distances
}

func getDistanceForOneClub(forThisClub club: String) -> String {
    var thisClubsDistance: String = ""
    if let dis = UserDefaults().value(forKey: "\(club)") {
        thisClubsDistance = "\(dis)"
    }

    return thisClubsDistance
}

func setUpDefaults() {
    UserDefaults().set("135", forKey: "Pitching Wedge")
    UserDefaults().set("145", forKey: "9 Iron")
    UserDefaults().set("155", forKey: "8 Iron")
    UserDefaults().set("165", forKey: "7 Iron")
    UserDefaults().set("175", forKey: "6 Iron")
    UserDefaults().set("185", forKey: "5 Iron")
}

func checkDefaults(clubsArray: [String]) {
    for club in clubsArray {
        let dist = UserDefaults().value(forKey: club)
        print("\(club) has key/distance of \(dist ?? "ERROR GETTING DISTANCE")")
    }
}

func pickClubFromDistance(_ clubs: [String], distance: Int) -> String {
    var pickedClub: String = ""
    var smallestDifference: Int = 999
    for club in clubs {
        if let thisClubDistance = Int(getDistanceForOneClub(forThisClub: club)) {
            let thisDiff = abs(thisClubDistance - distance)
            print("The distance between \(distance) and \(club)'s club distance of \(thisClubDistance) is \(thisDiff)")
            if thisDiff < smallestDifference {
                pickedClub = club
                smallestDifference = thisDiff
            }
        }
    }
    return pickedClub
}

func printBagOutLines(bag: UserBag) {
    for item in bag.allClubs2DArray {
        for item2 in item {
            print(item2)
        }
    }
}

func printArray(_ arr: [ClubObject]) -> String {
    var str = ""
    for club in arr {
        str += "\(club),"
    }
    return str
}

func saveCurrentClub() {
    for clubTypeIndex in 0 ..< mainBag.allClubs2DArray.count {
        for clubIndex in 0 ..< mainBag.allClubs2DArray[clubTypeIndex].count {
            let club = mainBag.allClubs2DArray[clubTypeIndex][clubIndex]
            if club == currentClub {
                mainBag.allClubs2DArray[clubTypeIndex][clubIndex] = currentClub
                doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
            }
        }
    }
}

// TODO: - Make this work for different type of hits
func deleteFromCurrentClubPrevHits(thisIndex index: Int, from swingType: swingTypeState) {
    var arrOfPrevHitsByType: [String]

    switch swingType {
    case .fullSwing:
        arrOfPrevHitsByType = currentClub.previousFullHits.components(separatedBy: ",")
    case .maxSwing:
        arrOfPrevHitsByType = currentClub.previousMaxHits.components(separatedBy: ",")
    case .threeFourths:
        arrOfPrevHitsByType = currentClub.previousThreeFourthsHits.components(separatedBy: ",")
    }
    if index < arrOfPrevHitsByType.count {
        arrOfPrevHitsByType.remove(at: index)
    }

    switch swingType {
    case .fullSwing:
        currentClub.previousFullHits = arrOfPrevHitsByType.joined(separator: ",")
        currentClub.averageFullDistance = getAvgFromStr(currentClub.previousFullHits)
    case .maxSwing:
        currentClub.previousMaxHits = arrOfPrevHitsByType.joined(separator: ",")
        currentClub.averageMaxDistance = getAvgFromStr(currentClub.previousMaxHits)
    case .threeFourths:
        currentClub.previousThreeFourthsHits = arrOfPrevHitsByType.joined(separator: ",")
        currentClub.averageThreeFourthsDistance = getAvgFromStr(currentClub.previousThreeFourthsHits)
    }

    saveCurrentClub()
}

func getAvgFromStr(_ str: String) -> Int {
    var sum = 0
    let arrFromStr = str.components(separatedBy: ",")
    var numItemsCount = 0
    for item in arrFromStr {
        if let strInt = Int(item) {
            numItemsCount += 1
            sum += strInt
        }
    }
    if numItemsCount != 0 {
        return Int(sum / numItemsCount)
    } else {
        return 0
    }
}

func removeEmptyFromPrevHits() {
    var prevHitsStr = currentClub.previousFullHits
    if prevHitsStr.last == "," {
        _ = prevHitsStr.removeLast()
    }
    currentClub.previousFullHits = prevHitsStr
    saveCurrentClub()
}
