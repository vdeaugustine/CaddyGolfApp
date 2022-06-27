//
//  MainClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/17/22.
//

import LineChartView
import SwiftPieChart
import SwiftUI

struct MainClubView: View {
    @EnvironmentObject var modelData: ModelData
    var club: Club
    var modelClub: Club {
        return modelData.bag.clubs.first(where: { $0 == club })!
    }
    @State var isShowingDeleteAlert = false
    var body: some View {
        ScrollView {
            VStack {
                swingsCircles(club: modelClub)
                NavigationLink {
                    EditClubView(club: modelClub)
                } label: {
                    Text("Edit Distance")
                }

                Section {
                    VStack {
                        LineChartForSwings(club: modelClub)
                    }

                } header: {
                    HStack {
                        Text("All Swings")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                        Spacer()
                    }
                }

                Section {
                    PieChart(club: modelClub)
                        .frame(height: 500)
                }

                header: {
                    HStack {
                        Text("Direction Tendancies")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                        Spacer()
                    }
                }

                Button {
                    isShowingDeleteAlert.toggle()
                } label: {
                    Text("Delete Club")
                        .foregroundColor(.red)
                }
                .alert("Deleting will permanently get rid of all club stats", isPresented: $isShowingDeleteAlert) {
                    Button("Delete", role: .destructive) { }
                    Button("Cancel", role: .cancel) { }
                }

                Spacer()
            }
            .padding()

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewStroke(club: club)
                    } label: {
                        Text("Add Stroke")
                    }
                }
            }
            .navigationTitle("\(club.getName().capitalized)")
        }
    }
}

struct MainClubView_Previews: PreviewProvider {
    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
    static var previews: some View {
        MainClubView(club: club)
            .preferredColorScheme(.dark)
    }
}
