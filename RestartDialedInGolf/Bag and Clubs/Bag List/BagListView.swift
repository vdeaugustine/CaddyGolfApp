//
//  BagListView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct BagListView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(modelData.bag.woods, id: \.self) { club in

                        ClubRowForBagList(club: club)
                    }
                } header: {
                    Text("Woods")
                }
                Section {
                    ForEach(modelData.bag.irons, id: \.self) { club in
                        ClubRowForBagList(club: club)
                    }
                } header: {
                    Text("Irons")
                }
            }
        }
        .navigationTitle("Your Bag")
        .toolbar {
            ToolbarItem {
                NavigationLink {
                    AddClubView()
                        .environmentObject(modelData)
                } label: {
                    Text("Add")
                }
            }
        }
    }
}

struct BagListView_Previews: PreviewProvider {
    static var previews: some View {
        BagListView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
