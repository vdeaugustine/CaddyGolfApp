//
//  ListOfChartsView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct ListOfChartsView: View {
    @EnvironmentObject var modelData: ModelData
    var highlightedClub: Club
    var body: some View {
        List {
            Section {
                PieChart(club: highlightedClub)
                    .frame(height: 500)
            }

            header: {
                HStack {
                    Text("Direction Tendencies")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.medium)

                    Spacer()
                }
            }
            Section {
                LineChartForSwings(club: self.highlightedClub)
                    .frame(height: 300)
            } header: {
                HStack {
                    Text("All Swings")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.medium)

                    Spacer()
                }
            }

            Section {
                if modelData.bag.notes.count <= 0 {
                    Text("You have no notes saved")
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
                }
                ForEach(Array(modelData.bag.notes).sorted(by: { $0.date > $1.date }), id: \.self) { n in
                    NoteRowView(note: n)
                }

            } header: {
                Text("Notes")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
        .listStyle(.sidebar)
        .frame(height: 1000)
    }
}


