//
//  AddClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct AddClubView: View {
    @EnvironmentObject var modelData: ModelData
    @State var clubType: ClubType = .wood
    @State var clubName: String = "Driver"
    @State var distance: String = "0"
    var names: [String] {
        switch clubType {
        case .wood:
            return ["Driver", "2 wood", "3 wood", "4 wood", "5 wood"]
        case .hybrid:
            return ["1 hybrid", "2 hybrid", "3 hybrid", "4 hybrid", "5 hybrid"]
        case .iron:
            return (1...9).map({"\($0) iron"})
        case .wedge:
            return (48...64).map({"\($0) wedge"})
        }
    }
    var body: some View {
        Form {
                Picker("Club Type", selection: $clubType) {
                    ForEach(ClubType.allCases, id: \.self) { theType in
                        Text(theType.rawValue.capitalized)
                            .tag(theType)
                    }
                }
                
                Picker("Club Number", selection: $clubName) {
                    ForEach(names, id: \.self) { theName in
                        Text(theName)
                    }
                }
            
            HStack {
                Text("Distance")
                Spacer()
                TextField("Distance", text: $distance)
                    .multilineTextAlignment(.trailing)
                Text("yards")
            }
            
        }
    }
}

struct AddClubView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddClubView()
            .environmentObject(ModelData(forType: .preview))
    }
}
