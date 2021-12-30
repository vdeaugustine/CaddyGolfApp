////
////  CoreDataFunctions.swift
////  CaddyApp
////
////  Created by Vincent DeAugustine on 12/20/21.
////
//
//import Foundation
//import UIKit
//
//func saveCoreData() {
//    do {
//        try coreDataContext.save()
//        doReload()
//    } catch {
//        print("ERROR WHEN TRYING SAVECOREDATAFUNC")
//    }
//}
//
//// MARK: - CLUB
//
//var mainBagModels = [SingleClub]()
//let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
///// Gets all items from CoreData and saves them to global mainBagModels var
//func getAllItems() {
//    do {
//        mainBagModels = try coreDataContext.fetch(SingleClub.fetchRequest())
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE GETALLITEMS")
//    }
//}
//
///// Gets all items from CoreData and saves them to global mainBagModels var
//func getAllItems(toReload tableView: UITableView) {
//    do {
//        mainBagModels = try coreDataContext.fetch(SingleClub.fetchRequest())
//        DispatchQueue.main.async {
//            tableView.reloadData()
//        }
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE GETALLITEMS")
//    }
//}
//
//func doReload() {
//}
//
///// The most basic creation of a SingleClub object. Saves after done
//func createItem(name: String, typeOfClub: clubTypesEnum) {
//    let newItem = SingleClub(context: coreDataContext)
//    newItem.name = name
//    newItem.type = typeOfClub.rawValue
//    do {
//        try coreDataContext.save()
//        doReload()
//    } catch {
//        print("ERROR WHEN TRYING TO CREATE CLUB")
//    }
//}
//
//func deleteItem(item: SingleClub) {
//    coreDataContext.delete(item)
//    do {
//        try coreDataContext.save()
//
//    } catch {
//        print("ERROR WHEN TRYING TO DELETE CLUB")
//    }
//}
//
///// This will remove all items from the global mainBagModels variable. It will also update CoreData
//func deleteAllFromCoreData() {
//    for v in 0 ..< mainBagModels.count {
//        let itemv = mainBagModels[v]
//        mainBagModels.remove(at: v)
//        coreDataContext.delete(itemv)
//    }
//    do {
//        try coreDataContext.save()
//
//    } catch {
//        print("ERROR WHEN TRYING TO DELETE ALL CLUBS")
//    }
//}
//
///// Update the name of the club. Saves after done
//func updateClub(club: SingleClub, newName: String) {
//    club.name = newName
//    do {
//        try coreDataContext.save()
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE CLUB UPDATE")
//    }
//}
//
///// Updates the average for a club. Saves after done
///// - newAverage: the number we are setting it to
///// - averageType: tells us which attribute to edit
//func updateClub(club: SingleClub, newAverage: Int, averageType: swingTypes) {
//    switch averageType {
//    case .threeFourths:
//        club.threeFourthsDistance = Int64(newAverage)
//    case .full:
//        club.fullSwingDistance = Int64(newAverage)
//    case .max:
//        club.maxDistance = Int64(newAverage)
//    }
//
//
//
//    var subIndexForClub : Int
//    var superIndex: Int
//    if let clubType = club.type  {
//
//        // Update bag
//        switch clubType {
//        case "Wood":
//            subIndexForClub = getIndexFromArray(for: club, type: .woods)
//            superIndex = 0
//            AppDelegate.userGolfBag.allClubs2DArr?[superIndex][subIndexForClub] = club
//        case "Hybrid":
//            subIndexForClub = getIndexFromArray(for: club, type: .hybrids)
//            superIndex = 1
//            AppDelegate.userGolfBag.allClubs2DArr?[superIndex][subIndexForClub] = club
//        case "Iron":
//            subIndexForClub = getIndexFromArray(for: club, type: .irons)
//            superIndex = 2
//            AppDelegate.userGolfBag.allClubs2DArr?[superIndex][subIndexForClub] = club
//        case "Wedge":
//            subIndexForClub = getIndexFromArray(for: club, type: .wedges)
//            superIndex = 3
//            AppDelegate.userGolfBag.allClubs2DArr?[superIndex][subIndexForClub] = club
//        default:
//            print()
//
//        }
//
//    }
//    // Not sure if we need to do this
//    do {
//        try coreDataContext.save()
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE CLUB UPDATE")
//    }
//
//
//
//
//}
//
///// Updates the array containing previous distances of this swing type for a club. Saves after done
///// - newAverage: the number we are setting it to
///// - averageType: tells us which attribute to edit
//func addPrevHitToClub(club: SingleClub, newHitDistance: Int, swingType: swingTypes) {
//    switch swingType {
//    case .threeFourths:
//        club.prevTFHits?.append(newHitDistance)
//    case .full:
//        club.prevFullSwingHits?.append(newHitDistance)
//    case .max:
//        club.prevMaxHits?.append(newHitDistance)
//    }
//
//    do {
//        try coreDataContext.save()
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE CLUB UPDATE")
//    }
//}
//
///// Remove an index from the club's array containing the previous hits for that swing type. Saves after done
///// - indexToRemove: index within the swing type array
///// - type of swing we are editing
//func removeFromPrevHitsArray(club: SingleClub, indexToRemove: Int, swingType: swingTypes) {
//    switch swingType {
//    case .threeFourths:
//
//        if (club.prevTFHits?.indices.contains(indexToRemove)) != nil {
//            club.prevTFHits?.remove(at: indexToRemove)
//        }
//    case .full:
//        if (club.prevFullSwingHits?.indices.contains(indexToRemove)) != nil {
//            club.prevFullSwingHits?.remove(at: indexToRemove)
//        }
//    case .max:
//        if (club.prevMaxHits?.indices.contains(indexToRemove)) != nil {
//            club.prevMaxHits?.remove(at: indexToRemove)
//        }
//    }
//
//    do {
//        try coreDataContext.save()
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE CLUB UPDATE")
//    }
//}
//
//
//// MARK: - BAG
///// Make the singleton golf bag have only standard clubs
//func makeGolfBagStandard() {
//    AppDelegate.userGolfBag.woodsArray = {
//        var retArr = [SingleClub]()
//        var startWith = 275
//        for item in standardWoods {
//            let club = SingleClub(context: coreDataContext)
//            club.name = item
//            club.fullSwingDistance = Int64(startWith)
//            club.maxDistance = Int64(startWith + 10)
//            club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
//            club.type = clubTypesEnum.woods.rawValue
//            retArr.append(club)
//            startWith -= 35
//        }
//        return retArr
//    }()
//    AppDelegate.userGolfBag.hybridsArray = {
//        var retArr = [SingleClub]()
//        var startWith = 210
//        for item in standardHybrids {
//            let club = SingleClub(context: coreDataContext)
//            club.name = item
//            club.fullSwingDistance = Int64(startWith)
//            club.maxDistance = Int64(startWith + 10)
//            club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
//            club.type = clubTypesEnum.hybrids.rawValue
//            retArr.append(club)
//            startWith -= 10
//        }
//        return retArr
//    }()
//    AppDelegate.userGolfBag.ironsArray = {
//        var retArr = [SingleClub]()
//        var startWith = 205
//        for item in standardIrons {
//            let club = SingleClub(context: coreDataContext)
//            club.name = item
//            club.fullSwingDistance = Int64(startWith)
//            club.maxDistance = Int64(startWith + 10)
//            club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
//            club.type = clubTypesEnum.irons.rawValue
//            retArr.append(club)
//            startWith -= 10
//        }
//        return retArr
//    }()
//    AppDelegate.userGolfBag.wedgesArray = {
//        var retArr = [SingleClub]()
//        var startWith = 125
//        for item in standardWedges {
//            let club = SingleClub(context: coreDataContext)
//            club.name = item
//            club.fullSwingDistance = Int64(startWith)
//            club.maxDistance = Int64(startWith + 10)
//            club.threeFourthsDistance = Int64(Double(club.fullSwingDistance) * 0.75)
//            club.type = clubTypesEnum.wedges.rawValue
//            retArr.append(club)
//            startWith -= 20
//        }
//        return retArr
//    }()
//
//    let woodsCount = Int64(AppDelegate.userGolfBag.woodsArray?.count ?? 0)
//    let hybridsCount = Int64(AppDelegate.userGolfBag.hybridsArray?.count ?? 0)
//    let ironsCount = Int64(AppDelegate.userGolfBag.ironsArray?.count ?? 0)
//    let wedgesCount = Int64(AppDelegate.userGolfBag.woodsArray?.count ?? 0)
//    AppDelegate.userGolfBag.numberOfClubs = woodsCount + hybridsCount + ironsCount + wedgesCount
//
//
//    if let wedgesArray = AppDelegate.userGolfBag.wedgesArray, let woodsArray = AppDelegate.userGolfBag.woodsArray, let hybridsArray = AppDelegate.userGolfBag.hybridsArray, let ironsArray = AppDelegate.userGolfBag.ironsArray
//    {
//        AppDelegate.userGolfBag.allClubs2DArr = [woodsArray, hybridsArray, ironsArray, wedgesArray]
//    }
//
//    AppDelegate.userGolfBag.clubTypes = clubTypes
//
////    AppDelegate.userGolfBag.numberOfClubs = Int64(AppDelegate.userGolfBag.woodsArray?.count ?? 0 + AppDelegate.userGolfBag.hybridsArray?.count ?? 0 + AppDelegate.userGolfBag.ironsArray?.count ?? 0 + AppDelegate.userGolfBag.wedgesArray?.count ?? 0)
//    saveCoreData()
//}
//
//
//
//func getGolfBagFromCoreData() {
//    do {
//        // subscripting with 0 because it returns an array of all Usergolfbag items but we know there is only one
//        AppDelegate.userGolfBag = try coreDataContext.fetch(UserGolfBag.fetchRequest())[0]
//    } catch {
//        print("ERROR WHEN TRYING TO SAVE GETALLITEMS")
//    }
//}
//
//
//func getIndexFromArray(for club: SingleClub, type: clubTypesEnum) -> Int{
//    var lookAtThisSubArray = 0
//    switch type {
//    case .irons:
//        lookAtThisSubArray = 2
//    case .woods:
//        lookAtThisSubArray = 0
//    case .wedges:
//        lookAtThisSubArray = 3
//    case .hybrids:
//        lookAtThisSubArray = 1
//    }
//    guard let arr = AppDelegate.userGolfBag.allClubs2DArr?[lookAtThisSubArray] else {
//        return -1
//    }
//    for currentIndex in 0 ..< arr.count {
//        if arr[currentIndex].name == club.name {
//            return currentIndex
//        }
//    }
//    return -1
//}
