//
//  DirectionSection.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct FlagColorSection: View {
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

