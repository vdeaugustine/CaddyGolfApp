//
//  AdviceFirstView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI

enum TypeOfShot: String, CaseIterable, Codable {
    case teeshot = "From the Tee Box"
    case fairwayShot = "From the Fairway"
    case approach = "Approach"
}

enum FlagColors: String, CaseIterable {
    case red, white, blue
}

enum BallPositions: String, CaseIterable {
    case flat, downhill, uphill, sidehill
}

struct AdviceFirstView: View {
    @StateObject var details = DetailsForAdvice()
    @EnvironmentObject var modelData: ModelData
    @State var showAlert: Bool = false
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
                if let advice = Advice.getAdvice(details: details, modelData: modelData) {
                    NavigationLink("Get Advice") {
                        AdviceAnswerView(advice: advice, highlightedClub: advice.closestClub)
                    }
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
            .environmentObject(ModelData(forType: .preview))
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
            Text("Shot Type")
            Spacer()
            Picker("Shot Type", selection: $details.typeOfShot) {
                ForEach(TypeOfShot.allCases, id: \.self) {
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
