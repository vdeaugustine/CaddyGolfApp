//
//  AdviceFirstView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI

enum TypeOfApproach: String, CaseIterable {
    case accuracy, distance
}

enum FlagColors: String, CaseIterable {
    case red, white, blue
}

enum BallPositions: String, CaseIterable {
    case flat, downhill, uphill, sidehill
}

class DetailsForAdvice: ObservableObject {
    @Published var distanceToPin: String = ""
    @Published var accuracyOrDistance: TypeOfApproach = .accuracy
    @Published var ballPosition: BallPositions = .flat
    @Published var distanceFocused: Bool = false
    @Published var flagColorChosen: FlagColors = .white
}

struct AdviceFirstView: View {
    @StateObject var details = DetailsForAdvice()

    var body: some View {
        VStack {
            Form {
                DetailsSectionForAdvice()

                DirectionSection()
            }
            .environmentObject(details)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AdviceAnswerView()
                } label: {
                    Text("Get Advice")
                }
            }
        }
        .onTapGesture {
            // Dismiss the keyboard when the screen is tapped
            dismissKeyboard()
        }
    }
}

struct AdviceFirstView_Previews: PreviewProvider {
    static var previews: some View {
        AdviceFirstView()
            .preferredColorScheme(.dark)
    }
}

struct DistanceToPinView: View {
    @EnvironmentObject var details: DetailsForAdvice

    var body: some View {
        HStack {
            Text("Distance to Pin")
            Spacer()
            TextField("Enter Yardage", text: $details.distanceToPin)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.blue)
                .keyboardType(.numberPad)
        }
    }
}

struct AccuracyOrDistanceRow: View {
    @EnvironmentObject var details: DetailsForAdvice
    var body: some View {
        HStack {
            Text("Accuracy or Distance")
            Spacer()
            Picker("Accuracy or Distance", selection: $details.accuracyOrDistance) {
                ForEach(TypeOfApproach.allCases, id: \.self) {
                    Text("\($0.rawValue.capitalized)")
                        .tag($0)
                }
            }.pickerStyle(.menu)
        }
    }
}

struct FlagButtonView: View {
    var thisFlagColor: FlagColors
    @EnvironmentObject private var details: DetailsForAdvice

    var chosenColor: Color {
        switch thisFlagColor {
        case .white:
            return Color.white
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        }
    }

    var body: some View {
        Button {
            details.flagColorChosen = thisFlagColor
        } label: {
            Image(systemName: details.flagColorChosen == thisFlagColor ? "flag.fill" : "flag")
                .font(.largeTitle)
                .foregroundColor(chosenColor)
                .padding(4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DirectionSection: View {
    var body: some View {
        Section("Direction") {
            HStack(alignment: .center) {
                ForEach(FlagColors.allCases, id: \.self) { flag in
                    Spacer()
                    FlagButtonView(thisFlagColor: flag)
                    Spacer()
                }
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct DetailsSectionForAdvice: View {
    var body: some View {
        Section("Details") {
            VStack {
                DistanceToPinView()
                AccuracyOrDistanceRow()
                BallPositionRow()
            }
            .padding([.top, .bottom], 5)
        }
    }
}

struct BallPositionRow: View {
    @EnvironmentObject private var details: DetailsForAdvice
    var body: some View {
        HStack {
            Text("Ball Position")
            Spacer()
            Picker("Accuracy or Distance", selection: $details.ballPosition) {
                ForEach(BallPositions.allCases, id: \.self) {
                    Text("\($0.rawValue.capitalized)")
                        .tag($0)
                }
            }.pickerStyle(.menu)
        }
    }
}
