//
//  SomeFunctions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/5/21.
//

import Foundation
import UIKit

func getAllDistances(forTheseClubs clubs: [String]) -> [Int] {
    var distances = [Int]()
    for clubType in clubs {
        
        if let dis = UserDefaults().value(forKey: "\(clubType)") {
//            print("got the value")
//            if let distanceInt = distanceStr as? String {
//                print("got the int")
//                distances.append(distanceInt)
//            }
            
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


func setUpDefaults (_ clubs: [String]) {
    for club in clubs {
        UserDefaults().set("100", forKey: "\(club)")
    }
}
