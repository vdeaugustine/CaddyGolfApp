//
//  AccuracyOrDistanceRow.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct AccuracyOrDistanceRow: View {
    @EnvironmentObject var viewModel: AdviceFirstViewModel
    var body: some View {
        HStack {
            Text("Shot Type")
            Spacer()
            Picker("Shot Type", selection: $viewModel.details.typeOfShot) {
                ForEach(TypeOfShot.allCases, id: \.self) {
                    Text("\($0.rawValue.capitalized)")
                        .tag($0)
                }
            }.pickerStyle(.menu)
        }
    }
}

