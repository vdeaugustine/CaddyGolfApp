//
//  BagListView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import BottomSheet
import SwiftUI

struct BagListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingAddClubSheet: Bool = false
    @State private var showingAlert = false
    private let sections: [ClubType] = [.wood, .iron, .hybrid, .wedge]
    var body: some View {
        print("Loading view")
        return VStack {
            List {
                ForEach(sections, id: \.self) { sectionClubType in
                    ClubSectionView(clubType: sectionClubType, deleteFunction: deleteClub(at:))
                }
            }
        }
        .navigationTitle("Your Bag")
        .navigationBarTitleDisplayMode(.inline)
        // This is a third party package that is a modification of sheet. It presents a sheet that only goes up a certain height, which is set by the parameter
        .bottomSheet(isPresented: $showingAddClubSheet, height: 400) {
            AddClubView(isShowing: $showingAddClubSheet)
                .environmentObject(modelData)
        }

        .toolbar {
            // Top right button pressed when user would like to add a club
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddClubSheet = true
                } label: {
                    Label("Add Club", systemImage: "plus")
                }
            }

            // Button the user can tap to reset their clubs to default. It will present an alert and if the alert is accepted, then it resets the clubs
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Reset") {
                    showingAlert = true
                }
                .alert("Are you sure you want to reset? This action cannot be undone", isPresented: $showingAlert) {
                    Button("Reset", role: .destructive) { modelData.bag.makeDefault()
                    }

                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    }

    
    func deleteClub(at offsets: IndexSet) {
        print("Called delete")
        guard let first = offsets.first else { return }
        let clubToDelete = modelData.bag.clubsArray[first]
        print("Delete this club", clubToDelete)
        print("Model bag before", modelData.bag.clubs)
        guard modelData.bag.clubs.remove(clubToDelete) != nil else {
            print("Error, did not remove correctly")
            return
        }
        print("Model data after", modelData.bag.clubs)
    }
}

struct BagListView_Previews: PreviewProvider {
    static var previews: some View {
        BagListView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
