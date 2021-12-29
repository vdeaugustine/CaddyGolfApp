//
//  NewCoreDataFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/28/21.
//

import Foundation
import UIKit


let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let mainBagToUse = AppDelegate.userGolfBag





func saveCoreData() {
    do {
        try coreDataContext.save()
    }
    catch {
        print("Problem saving core data")
    }
}

func printIronsCoreData() {
    do {
        let bagFetchRequest = try coreDataContext.fetch(UserGolfBag.fetchRequest())
        let tempGolfBag = bagFetchRequest[0]
//        let ironsSet = tempGolfBag.ironsArr! // this is an NSSet
        if let testArr = tempGolfBag.ironsArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit38")
        }
    }
    catch {
        print("Problem you know where42")
        
    }
}

func makeStandardIrons() {
    //    let irons: [SingleClub] = {
    //        var retArr = [SingleClub]()
    let golfBag = AppDelegate.userGolfBag
    
    var startWith = 205
    for item in standardIrons {
        let club = SingleClub(context: coreDataContext)
        club.name = item
        club.fullSwingDistance = Int64(startWith)
        club.maxDistance = Int64(startWith + 10)
        club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
        club.type = clubTypesEnum.irons.rawValue
        //            retArr.append(club)
        startWith -= 10
        print("adding", club.name!, "to bag")
        golfBag.addToIronsArr(club)
        print("printing irons array")
        if let testArr = golfBag.ironsArr?.allObjects as? [SingleClub] {
            for cx in testArr {
                print(cx.name!)
            }
        } else {
            print("Problem getting testArr in printing shit")
        }
        
            
        
    }
    
    do {
        try coreDataContext.save()
    }
    catch {
        print("Problem saving core data")
    }    //        return retArr
    //    }()
}
