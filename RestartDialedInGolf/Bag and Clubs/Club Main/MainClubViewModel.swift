//
//  MainClubViewModel.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/26/22.
//

import Foundation
import SwiftUI

final class MainClubViewModel: ObservableObject {
    
    init(club: Club, modelData: ModelData) {
        self.modelData = modelData
        self.club = club
    }
    
    var modelData: ModelData
    var club: Club
    var modelClub: Club {
        guard let theClub = modelData.bag.clubs.first(where: { $0 == club }) else {
            return Club(number: "NA", type: .wood, name: "NA", distance: 999)
        }
        
        return theClub
    }

    
    
}
