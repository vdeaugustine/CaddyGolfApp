//
//  MainClubViewModel.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/24/22.
//

import Foundation

final class MainClubViewModel: ObservableObject {
    @Published var modelData: ModelData
    @Published var club: Club
    @Published var isShowingDeleteAlert = false
    @Published var bag: Bag? = nil
    
    init (modelData: ModelData, club: Club) {
        self.modelData = modelData
        self.club = club
    }
}
