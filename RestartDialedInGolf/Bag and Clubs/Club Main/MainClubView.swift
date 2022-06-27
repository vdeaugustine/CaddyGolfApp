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
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var modelData: ModelData
    @State var isShowingDeleteAlert = false
    @StateObject var viewModel: MainClubViewModel
    var body: some View {
        ScrollView {
            VStack {
                swingsCircles(club: viewModel.modelClub)
                NavigationLink {
                    EditClubView(club: viewModel.modelClub)
                } label: {
                    Text("Edit Distance")
                }

                Section {
                    VStack {
                        LineChartForSwings(club: viewModel.modelClub)
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
                    PieChart(club: viewModel.modelClub)
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
                .confirmationDialog("Deleting will permanently get rid of all club stats", isPresented: $isShowingDeleteAlert, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        do {
                            dismiss()
                            try modelData.deleteClub(viewModel.modelClub)
                            
                        } catch {
                            // show alert or something
                            print(error)
                        }
                    }
                }

                Spacer()
            }
            .padding()

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewStroke(club: viewModel.modelClub)
                    } label: {
                        Text("Add Stroke")
                    }
                }
            }
            .navigationTitle("\(viewModel.modelClub.getName().capitalized)")
        }
    }
}

//struct MainClubView_Previews: PreviewProvider {
//    static let viewModel: MainClubViewModel
//    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
//    static var previews: some View {
//        MainClubView(club: club)
//            .preferredColorScheme(.dark)
//    }
//}
