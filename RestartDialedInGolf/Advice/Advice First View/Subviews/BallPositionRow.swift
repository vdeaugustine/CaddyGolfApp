//
//  BallPositionRow.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct BallPositionRow: View {
    @EnvironmentObject private var viewModel: AdviceFirstViewModel
    var body: some View {
        HStack {
            Text("Ball Position")
            Spacer()
            Picker("Ball Position", selection: $viewModel.details.ballPosition) {
                ForEach(BallPositions.allCases, id: \.self) {
                    Text("\($0.rawValue.capitalized)")
                        .tag($0)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
