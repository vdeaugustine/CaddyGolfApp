//
//  FlagButtonView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct FlagButtonView: View {
    var thisFlagColor: FlagColors
    @EnvironmentObject private var viewModel: AdviceFirstViewModel

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
            viewModel.details.flagColorChosen = thisFlagColor
        } label: {
            Image(systemName: viewModel.details.flagColorChosen == thisFlagColor ? "flag.fill" : "flag")
                .font(.largeTitle)
                .foregroundColor(chosenColor)
                .padding(4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

