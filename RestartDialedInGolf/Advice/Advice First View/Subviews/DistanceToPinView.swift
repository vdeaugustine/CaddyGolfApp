//
//  DistanceToPinView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct DistanceToPinView: View {
    @EnvironmentObject var viewModel: AdviceFirstViewModel

    var body: some View {
        HStack {
            Text("Distance to Pin")
            Spacer()
            TextField("Enter Yardage", text: $viewModel.details.distanceToPin)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.blue)
                .keyboardType(.numberPad)
        }
    }
}
