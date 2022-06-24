//
//  AddStrokeView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI

enum TargetChoices: String, CaseIterable {
    case fir = "FIR"
    case gir = "GIR"
    case neither = "Neither"
    case missedFIR = "Missed FIR"
    case missedGIR = "Missed GIR"
}

struct AddResultsView: View {
    @Environment(\.dismiss) var dismiss
    var club: Club
    @EnvironmentObject var modelData: ModelData
    @State var distance: String = "0"
    @State var directionChosen: SwingDirection = .straight
    @State var targetChoiceSelected: TargetChoices = .gir
    var body: some View {
        Form {
            Section("How far did you hit the ball?") {
                HStack {
                    Text("Distance Traveled")

                    TextField("\(distance)", text: $distance, onEditingChanged: { isEditing in
                        if isEditing {
                            self.distance = ""
                        }

                    })
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)

                    Text("yards")
                }
            }

            Section("Did you hit your target?") {
                HStack {
                    Text("FIR, GIR, or Neither")
                    Spacer()
                    Picker("Success Result", selection: $targetChoiceSelected) {
                        ForEach(TargetChoices.allCases, id: \.self) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }

            Section("Direction") {
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        directionChosen = .left
                    } label: {
                        Image(systemName: "arrow.up.left")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == .left ? Color.red : .white)
                    Spacer()
                    Button {
                        directionChosen = .straight
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == .straight ? .blue : .white)
                    Spacer()
                    Button {
                        directionChosen = .right
                    } label: {
                        Image(systemName: "arrow.up.right")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == .right ? Color.red : .white)
                    Spacer()
                }
                .multilineTextAlignment(.center)
            }
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .tint(.blue)
        .navigationTitle("Add Stroke for \(club.getName())")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    guard let distanceInt = Int(self.distance) else { return }
                    var directionToUse: SwingDirection
                    switch directionChosen {
                    case .left:
                        directionToUse = .left
                    case .right:
                        directionToUse = .right
                    case .straight:
                        directionToUse = .straight
                    }

                    var newSwing: Swing
                    
                    switch targetChoiceSelected {
                    case .fir:
                        newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date(), hitFairway: true, attemptingFairway: true)
                    case .gir:
                        newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date(), hitGreen: true, attemptingGreen: true)
                    case .neither:
                        newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date())
                    case .missedFIR:
                        newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date(), hitFairway: false, attemptingFairway: true)
                    case .missedGIR:
                        newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date(), hitGreen: false, attemptingGreen: true)
                    }
                    
                    

                    do {
                        try modelData.addStrokeToClub(stroke: newSwing, club: self.club)
                    } catch {
                        print(error)
                    }

                    dismiss()
                }
            }
        }
    }
}

struct AddResultsView_Previews: PreviewProvider {
    static var club = Club(number: "9", type: .iron, name: "9 iron", distance: 139)
    static var previews: some View {
        AddResultsView(club: club)
            .preferredColorScheme(.dark)
            .environmentObject(ModelData(forType: .preview))
    }
}
