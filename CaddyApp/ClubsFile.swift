//
//  ClubsFile.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/6/21.
//

import Foundation
import UIKit


let clubTypes: [String] = ["Woods", "Hybrids", "Irons"]
let clubs : [String] = ["Pitching Wedge", "9 Iron", "8 Iron","7 Iron","6 Iron","5 Iron","4 Iron", "Driver"]
let woods: [String] = ["Driver", "2 Wood", "3 Wood", "4 Wood", "5 Wood"]
let hybrids: [String] = ["1 Hybrid", "2 Hybrid", "3 Hybrid", "4 Hybrid", "5 Hybrid"]
let irons : [String] = ["9 Iron", "8 Iron","7 Iron","6 Iron","5 Iron","4 Iron", "3 Iron", "2 Iron", "1 Iron"]
var allClubsByType = [woods, hybrids, irons]



struct ClubObject {
    var clubType : String
    var clubOptions : [String]
}

func setUpClubObjects () -> [ClubObject]{
    var clubsList = [ClubObject]()
    clubsList.append(ClubObject(clubType: "Woods", clubOptions: woods))
    clubsList.append(ClubObject(clubType: "Hybrids", clubOptions: hybrids))
    clubsList.append(ClubObject(clubType: "Irons", clubOptions: irons))


    return clubsList
}


//func deleteClub(firstIndex: Int, secondIndex: Int, from thisArray: [[String]]) {
//    var tempArr = thisArray
//    tempArr = tempArr[firstIndex].remove(at: secondIndex)
//}
