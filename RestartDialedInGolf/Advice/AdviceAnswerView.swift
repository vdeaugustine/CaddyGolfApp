//
//  AdviceAnswerView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import AVKit
import SwiftUI

struct AdviceAnswerView: View {
    @State var audioPlayer: AVAudioPlayer!
    @EnvironmentObject var modelData: ModelData
    let advice: Advice
    @State var highlightedClub: Club
    @Binding var rootIsActive: Bool
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .lastTextBaseline) {
                    Text("Recommendation")
                        .font(.title)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.75)
                }
                .padding()
                ColorYardage(advice: advice, club: advice.closestClub, color: .green)
                ColorYardage(advice: advice, club: advice.secondClosestClub, color: .red)

                Picker("Highlighted Club", selection: $highlightedClub) {
                    Text("\(advice.closestClub.getName().capitalized)")
                        .tag(advice.closestClub)
                    Text("\(advice.secondClosestClub.getName().capitalized)")
                        .tag(advice.secondClosestClub)
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    Section {
                        PieChart(club: highlightedClub)
                            .frame(height: 500)
                    }

                    header: {
                        HStack {
                            Text("Direction Tendancies")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.medium)

                            Spacer()
                        }
                    }
                    Section {
                        VStack {
                            if highlightedClub.getSwings().count > 0 {
                                LineChartForSwings(club: highlightedClub)
                            } else {
                                HStack {
                                    Image(systemName: "exclamationmark.circle")
                                    Text("No swings yet recorded for club")
                                }
                                .font(.system(size: 17))
                            }
                        }
                        .frame(height: highlightedClub.getSwings().count > 0 ? 300 : 25)

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

                HStack {
                    Spacer()
                    Button("Add result for this swing") {
                        // Go to add result
                    }
                    Spacer()
                }
                .padding(.bottom, 35)
            }
        }
        .navigationTitle("\(advice.realDistance ?? 0) yards")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddResultsView(club: advice.closestClub, shouldPopToRootView: $rootIsActive)
                } label: {
                    Text("Add Result")
                        .foregroundColor(.blue)
                }
                .isDetailLink(false)
            }
        }

        .onAppear {
            let sound = Bundle.main.path(forResource: "swing", ofType: "wav")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.play()
        }
        
    }
}

struct AdviceAnswerView_Previews: PreviewProvider {
    static let advice: Advice = {
        let cc = Club(number: "Driver", type: .wood, name: "Driver", distance: 250)
        let scc = Club(number: "3", type: .wood, name: "3 wood", distance: 225)
        return Advice(closestClub: cc, secondClosestClub: scc, typeOfShot: .teeshot, targetDistance: 210, realDistance: 210)
    }()

    @State static var active: Bool = false
    static var previews: some View {
        AdviceAnswerView(advice: advice, highlightedClub: advice.closestClub, rootIsActive: $active)
            .preferredColorScheme(.dark)
            .environmentObject(ModelData(forType: .preview))
    }
}

struct LabelForClub: View {
    var club: Club
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(club.getName().capitalized)
                .font(.system(size: 30))

                .padding(.leading, 20)
            Text("\(club.getDistance()) yards")
                .font(.title2)
                .padding([.leading])
        }
        .padding()
    }
}

struct ColorYardage: View {
    let advice: Advice
    let club: Club
    let color: Color
    var backColor: Color {
        if color == .red {
            return .init(UIColor(red: 0 / 255, green: 32 / 255, blue: 87 / 255, alpha: 1))
        }
        if color == .green {
            return .init(UIColor(red: 0, green: 87 / 255, blue: 23 / 255, alpha: 1))
        }
        return .clear
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            LabelForClub(club: club)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backColor)
                if let realDistance = advice.realDistance {
                    let inFront: String = club.getDistance() - realDistance >= 0 ? "+" : "-"
                    Text(inFront + "\(abs(club.getDistance() - realDistance))")
                        .foregroundColor(.green)
                        .fontWeight(.medium)
                }
            }
            .frame(width: 60, height: 40)
        }
    }
}
