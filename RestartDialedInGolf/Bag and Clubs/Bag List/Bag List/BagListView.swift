//
//  BagListView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import AlertToast
import SwiftUI

struct BagListView: View {
    // MARK: - Properties

    @EnvironmentObject var modelData: ModelData
    @State private var showingAlert = false
    private let sections: [ClubType] = [.wood, .iron, .hybrid, .wedge]

    // MARK: - Body

    var body: some View {
        VStack {
            // MARK: List of clubs

            List {
                ForEach(sections, id: \.self) { sectionClubType in

                    // MARK: Club type section

                    ClubSectionView(clubType: sectionClubType)
                }
            }
        }

        // MARK: Modifiers for top level Vstack
        .navigationTitle("Your Bag")
        .navigationBarTitleDisplayMode(.inline)

        // MARK: - Toolbar

        .toolbar {
            // MARK: Reset bag button
            // Button the user can tap to reset their clubs to default. It will present an alert and if the alert is accepted, then it resets the clubs
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Reset") {
                    showingAlert = true
                }
                .confirmationDialog("Are you sure you want to reset? This action cannot be undone", isPresented: $showingAlert, titleVisibility: .visible) {
                    Button("Reset", role: .destructive) {
                        modelData.makeDefault()
                    }
                }
            }

            // MARK: Add Club button
            // Top right button pressed when user would like to add a club
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddClubView()
                } label: {
                    Label("Add Club", systemImage: "plus")
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
