//
//  AdviceFirstView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI

struct AdviceFirstView: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject private var viewModel = AdviceFirstViewModel()
    var body: some View {
        VStack {
            Form {
                // All the details except for Flag
                DetailsSectionForAdvice()
                FlagColorSection()
            }
            .environmentObject(viewModel)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let advice = Advice.getAdvice(details: viewModel.details,
                                                 modelData: modelData) {
                    NavigationLink(isActive: $viewModel.isActive) {
                        AdviceAnswerView(advice: advice,
                                         highlightedClub: advice.closestClub,
                                         rootIsActive: $viewModel.isActive)
                    } label: {
                        Text("Get Advice")
                    }
                    .isDetailLink(false)
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
