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
    var club: Club
    @State var isShowingDeleteAlert = false
    var body: some View {
        ScrollView {
            VStack {
                swingsCircles(club: club)

                Section {
                    VStack {
                        LineChartForSwings(club: club)
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
                    PieChart(club: club)
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
        }

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

struct MainClubView_Previews: PreviewProvider {
    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
    static var previews: some View {
        MainClubView(club: club)
            .preferredColorScheme(.dark)
    }
}
