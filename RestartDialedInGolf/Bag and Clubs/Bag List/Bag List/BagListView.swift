//
//  BagListView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import BottomSheet
import SwiftUI

func loadBag() -> Bag? {
    var retBag: Bag?
    if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
        do {
            let decoder = JSONDecoder()
            let thisBag = try decoder.decode(Bag.self, from: existingBag)
            retBag = thisBag
        } catch {
            fatalError("Couldn't parse bag as Bag :\n\(error)")
        }
    }
    return retBag
}

struct BagListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingAddClubSheet: Bool = false
    @State private var showingAlert = false
    private let sections: [ClubType] = [.wood, .iron, .hybrid, .wedge]
    var body: some View {
        VStack {
            List {
                ForEach(sections, id: \.self) { sectionClubType in
                    ClubSectionView(clubType: sectionClubType)
                }
            }
        }
        .navigationTitle("Your Bag")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
//            bag = modelData.loadBag()
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
        guard let first = offsets.first else { return }
        let clubToDelete = modelData.bag.clubs.sorted(by: { $0.getDistance() > $1.getDistance() })[first]
        guard modelData.bag.clubs.remove(clubToDelete) != nil else {
            print("Error, did not remove correctly")
            return
        }
        modelData.saveBag()
    }
}

struct BagListView_Previews: PreviewProvider {
    static var previews: some View {
        BagListView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
