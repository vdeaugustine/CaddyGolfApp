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
    @State var club: Club
    @State var isShowingDeleteAlert = false
    @State var bag: Bag? = nil
    var body: some View {
        ScrollView {
            if let thisBag = bag {
                VStack {
                    swingsCircles(club: thisBag.clubs.first(where: { $0 == club })!)

                    Section {
                        VStack {
                            LineChartForSwings(club: modelData.bag.clubs.first(where: { $0 == club })!)
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
                        PieChart(club: modelData.bag.clubs.first(where: { $0 == club })!)
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
                            AddNewStroke(club: $club, bag: $bag)
                        } label: {
                            Text("Add Stroke")
                        }
                    }
                }
                .navigationTitle("\(club.getName().capitalized)")
            }
            else {
                Text("NO CLUB FOUND")
            }
            
        }
        .onAppear {
            print("called appear")
            bag = modelData.loadBag()
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
