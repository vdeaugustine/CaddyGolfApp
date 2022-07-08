//
//  ClubSectionView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI

struct ClubSectionView: View {
    // MARK: - Properties
    @EnvironmentObject var modelData: ModelData
    var clubType: ClubType
    var theseClubs: [Club] {
        switch clubType {
        case .wood:
            return modelData.bag.woods
        case .hybrid:
            return modelData.bag.hybrids
        case .iron:
            return modelData.bag.irons
        case .wedge:
            return modelData.bag.wedges
        }
    }
    // MARK: - Body
    var body: some View {
        Section {
            ForEach(theseClubs, id: \.self.id) { club in
                NavigationLink {
                    MainClubView(viewModel: MainClubViewModel(club: club,
                                                              modelData: modelData))
                }
                label: {
                    // MARK: Club Row View
                    ClubRowForBagList(club: club)
                }
            }
        } header: {
            Text("\(clubType.rawValue)s".capitalized)
                .font(.title3)
                .foregroundColor(.blue)
        }
    }
}

// MARK: - Preview

// struct ClubSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClubSectionView()
//    }
// }
