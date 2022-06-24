//
//  AddClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct AddClubView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var modelData: ModelData
    @State var clubType: ClubType = .wood
    @State var clubName: String = "Driver"
    @State var distance: Int = 150
    @Binding var isShowing: Bool

    var names: [String] {
        switch clubType {
        case .wood:
            return ["Driver", "2 wood", "3 wood", "4 wood", "5 wood"]
        case .hybrid:
            return ["1 hybrid", "2 hybrid", "3 hybrid", "4 hybrid", "5 hybrid"]
        case .iron:
            return (1 ... 9).map({ "\($0) iron" })
        case .wedge:
            return (48 ... 64).map({ "\($0) wedge" })
        }
    }

    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().alwaysBounceVertical = false
        return VStack {
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
                    Picker("Club Number", selection: $clubName) {
                        ForEach(names, id: \.self) { theName in
                            Text(theName)
                        }
                    }
                }

                HStack {
                    Text("Distance")
                    Spacer()
                    Picker("Distance", selection: $distance) {
                        ForEach(50..<301) { theDistance in
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
                
                isShowing = false
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
            
        }
        
    }
}

struct AddClubView_Previews: PreviewProvider {
    @State static var isShowingSheet = false
    static var previews: some View {
        AddClubView(isShowing: $isShowingSheet)
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
