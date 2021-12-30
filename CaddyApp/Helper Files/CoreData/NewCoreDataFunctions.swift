//
//  NewCoreDataFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/28/21.
//

import Foundation
import UIKit

let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//let mainBagToUse = AppDelegate.userGolfBag




func saveCoreData() {
    do {
        try coreDataContext.save()
    } catch {
        print("Problem saving core data")
    }
}

func deleteClub(from clubTypeArr: clubTypesEnum, at thisIndex: Int) {
    let clubToDelete: SingleClub

    switch clubTypeArr {
    case .irons:
        clubToDelete = AppDelegate.userGolfBag.ironsArr!.allObjects[thisIndex] as! SingleClub
        AppDelegate.userGolfBag.removeFromIronsArr(clubToDelete)
    case .woods:
        clubToDelete = AppDelegate.userGolfBag.woodsArr!.allObjects[thisIndex] as! SingleClub
        AppDelegate.userGolfBag.removeFromWoodsArr(clubToDelete)
    case .wedges:
        clubToDelete = AppDelegate.userGolfBag.wedgesArr!.allObjects[thisIndex] as! SingleClub
        AppDelegate.userGolfBag.removeFromWedgesArr(clubToDelete)
    case .hybrids:
        clubToDelete = AppDelegate.userGolfBag.hybridsArr!.allObjects[thisIndex] as! SingleClub
        AppDelegate.userGolfBag.removeFromHybridsArr(clubToDelete)
    }

//    coreDataContext.delete(clubToDelete)

    saveCoreData()
}

func makeStandardBag() {
    makeStandardWoods()
    makeStandardIrons()
    makeStandardHybrids()
    makeStandardWedges()
}

func makeStandardWoods() {
    var startWith = 275
    for item in standardWoods {
        let club = SingleClub(context: coreDataContext)
        club.name = item
        club.fullSwingDistance = Int64(startWith)
        club.maxDistance = Int64(startWith + 10)
        club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
        club.type = clubTypesEnum.woods.rawValue
        startWith -= 35
        print("adding", club.name!, "to bag")
        AppDelegate.userGolfBag.addToWoodsArr(club)
        print("printing woods array")
        if let testArr = AppDelegate.userGolfBag.woodsArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit")
        }
    }
    saveCoreData()
}

func makeStandardHybrids() {
    var startWith = 210
    for item in standardHybrids {
        let club = SingleClub(context: coreDataContext)
        club.name = item
        club.fullSwingDistance = Int64(startWith)
        club.maxDistance = Int64(startWith + 10)
        club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
        club.type = clubTypesEnum.hybrids.rawValue
        startWith -= 10
        print("adding", club.name!, "to bag")
        AppDelegate.userGolfBag.addToHybridsArr(club)
        print("printing hybrids array")
        if let testArr = AppDelegate.userGolfBag.hybridsArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit")
        }
    }
    saveCoreData()
}

func makeStandardIrons() {
    var startWith = 205
    for item in standardIrons {
        let club = SingleClub(context: coreDataContext)
        club.name = item
        club.fullSwingDistance = Int64(startWith)
        club.maxDistance = Int64(startWith + 10)
        club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
        club.type = clubTypesEnum.irons.rawValue
        startWith -= 10
        print("adding", club.name!, "to bag")
        AppDelegate.userGolfBag.addToIronsArr(club)
        print("printing irons array")
        if let testArr = AppDelegate.userGolfBag.ironsArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit")
        }
    }
    saveCoreData()
}

func makeStandardWedges() {
    var startWith = 125
    for item in standardWedges {
        let club = SingleClub(context: coreDataContext)
        club.name = item
        club.fullSwingDistance = Int64(startWith)
        club.maxDistance = Int64(startWith + 10)
        club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
        club.type = clubTypesEnum.wedges.rawValue
        startWith -= 20
        print("adding", club.name!, "to bag")
        AppDelegate.userGolfBag.addToWedgesArr(club)
        print("printing wedges array")
        if let testArr = AppDelegate.userGolfBag.wedgesArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit")
        }
    }
    saveCoreData()
}
