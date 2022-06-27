//
//  AddStrokeView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI
import AlertToast

struct AddNewStroke: View {
    @Environment(\.dismiss) var dismiss
    var club: Club
    @EnvironmentObject var modelData: ModelData
    @State var distance: String = "0"
    @State var directionChosen: String = "straight"
    @State var clubType: ClubType = .wood
    @State var clubNumber: Int = 1
    @FocusState var distanceFocused: Bool
    @State var showToast = false

    private var woodNumbers: [String] {
        return modelData.bag.woods.map({ $0.getNumber() })
    }

    private var ironNumbers: [String] {
        return modelData.bag.irons.map({ $0.getNumber() })
    }

    private var hybridNumbers: [String] {
        return modelData.bag.hybrids.map({ $0.getNumber() })
    }

    private var wedgeNumbers: [String] {
        return modelData.bag.wedges.map({ $0.getNumber() })
    }

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
                        .focused($distanceFocused)

                    Text("yards")
                }
            }

            Section("Direction") {
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        directionChosen = "left"
                    } label: {
                        Image(systemName: "arrow.up.left")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == "left" ? Color.red : .white)
                    Spacer()
                    Button {
                        directionChosen = "straight"
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == "straight" ? .blue : .white)
                    Spacer()
                    Button {
                        directionChosen = "right"
                    } label: {
                        Image(systemName: "arrow.up.right")
                            .font(.largeTitle)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(directionChosen == "right" ? Color.red : .white)
                    Spacer()
                }
                .multilineTextAlignment(.center)
            }
        }
        .onTapGesture {
            distanceFocused = false
        }
        .tint(.blue)
        .navigationTitle("Add Stroke for \(club.getName())")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Save") {
                    do {
                        try saveNewStroke(distance: self.distance, directionChosen: self.directionChosen, modelData: self.modelData, club: club)
                            dismiss()
                    } catch {
                        showToast.toggle()
                    }
                    
                }
            }
        }
        .toast(isPresenting: $showToast, duration: 5, alert: {
            AlertToast(displayMode: .banner(.slide), type: .error(.blue), title: "Could not save", subTitle: "Something happened when trying to save stroke. Exit the app and try again")
        })
    }
}

func saveNewStroke(distance: String, directionChosen: String, modelData: ModelData, club: Club) throws {
    guard let distanceInt = Int(distance) else { return }
    var directionToUse: SwingDirection
    switch directionChosen {
    case "left":
        directionToUse = .left
    case "right":
        directionToUse = .right
    case "straight":
        directionToUse = .straight
    default:
        directionToUse = .straight
    }

    let newSwing = Swing(distance: distanceInt, direction: directionToUse, date: Date())

    do {
        try modelData.addStrokeToClub(stroke: newSwing, club: club)
    } catch {
        print(error)
    }
}

struct AddNewStroke_Previews: PreviewProvider {
    static var club = Club(number: "9", type: .iron, name: "9 iron", distance: 139)
    static var previews: some View {
        AddNewStroke(club: club)
            .preferredColorScheme(.dark)
            .environmentObject(ModelData(forType: .preview))
    }
}
