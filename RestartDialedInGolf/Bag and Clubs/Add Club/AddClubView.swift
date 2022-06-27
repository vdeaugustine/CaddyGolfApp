//
//  AddClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI
import AlertToast

struct AddClubView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var modelData: ModelData
    @State var clubType: ClubType = .wood
    @State var clubNumber: String = "Driver"
    @State var distance: Int = 150
    @State var showToast = false

    var numbers: [String] {
        switch clubType {
        case .wood:
            return ["Driver", "2", "3", "4", "5"]
        case .hybrid:
            return ["1", "2", "3", "4", "5"]
        case .iron:
            return (1 ... 9).map({ "\($0)" })
        case .wedge:
            return (48 ... 64).map({ "\($0)" })
        }
    }

    var body: some View {
         VStack {
            Form {
                HStack {
                    Text("Club Type")
                    Spacer()
                    Picker("Club Type", selection: $clubType) {
                        ForEach(ClubType.allCases, id: \.self) { theType in
                            Text(theType.rawValue.capitalized)
                                .tag(theType)
                        }
                    }
                }

                HStack {
                    Text("Club Number")
                    Spacer()
                    Picker("Club Number", selection: $clubNumber) {
                        ForEach(numbers, id: \.self) { theName in
                            Text(theName)
                        }
                    }
                }

                HStack {
                    Text("Distance")
                    Spacer()
                    Picker("Distance", selection: $distance) {
                        ForEach(50 ..< 301) { theDistance in
                            if theDistance % 5 == 0 {
                                Text("\(theDistance)")
                            }
                        }
                    }
                }
            }
            .frame(height: 220)
            .pickerStyle(.menu)

            Button {
                // Save
                let clubToAdd = Club(number: clubNumber, type: clubType, name: clubNumber.lowercased() == "driver" ? "Driver" : clubNumber + clubType.rawValue.capitalized, distance: distance)
                do {
                    try modelData.addClub(clubToAdd)
                } catch {
                    print(error)
                    showToast.toggle()
                    
                }

            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding([.leading, .trailing], 30)
                    Text("Save Club")
                        .foregroundColor(.white)
                        .font(.title)
                }
            }
             
             Spacer()
        }
         .toast(isPresenting: $showToast, alert: {
             AlertToast(displayMode: .alert, type: .error(.red), title: "Club Already Exists")
         })
    }
}

struct AddClubView_Previews: PreviewProvider {
    static var previews: some View {
        AddClubView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
