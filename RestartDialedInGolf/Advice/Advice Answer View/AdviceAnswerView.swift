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

                Spacer(minLength: 30)

                if advice.ballPosition != .flat {
                    BallPositionButtonView(advice: advice)
                }

                Picker("Highlighted Club", selection: $highlightedClub) {
                    Text("\(advice.closestClub.getName().capitalized)")
                        .tag(advice.closestClub)
                    Text("\(advice.secondClosestClub.getName().capitalized)")
                        .tag(advice.secondClosestClub)
                }
                .pickerStyle(.segmented)
                .padding()

                ListOfChartsView(highlightedClub: highlightedClub)

                HStack {
                    Spacer()
                    NavigationLink("Add result for this swing") {
                        // Go to add result
                        AddResultsView(club: highlightedClub, shouldPopToRootView: $rootIsActive)
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
                    AddResultsView(club: highlightedClub, shouldPopToRootView: $rootIsActive)
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
        return Advice(closestClub: cc, secondClosestClub: scc, typeOfShot: .teeshot, targetDistance: 210, realDistance: 210, ballPosition: .downhill)
    }()

    @State static var active: Bool = false
    static var previews: some View {
        AdviceAnswerView(advice: advice, highlightedClub: advice.closestClub, rootIsActive: $active)
            .preferredColorScheme(.dark)
            .environmentObject(ModelData(forType: .preview))
    }
}
