//
//  UserBag.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/12/21.
//

import Foundation
import UIKit


struct UserBag: Codable {
    
    var types: [String]
    var nineIron : Int
    var eightIron : Int
    var sevenIron : Int
    var sixIron : Int
    var irons : [String]
//    var fiveIron : Int
//    var fourIron : Int
//    var threeIron : Int
//    var twoIron : Int
//    var oneIron : Int
    
}



func defaultBag() -> UserBag {
    let newBag = UserBag(types: ["Irons"], nineIron: 140, eightIron: 150, sevenIron: 160, sixIron: 170, irons: ["6 Iron", "7 Iron", "8 Iron", "9 Iron"])
    return newBag
    
}

