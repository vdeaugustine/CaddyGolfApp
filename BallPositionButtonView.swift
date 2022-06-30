//
//  BallPositionButtonView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct BallPositionButtonView: View {
    var advice: Advice
    var body: some View {
        HStack {
            Spacer()

            NavigationLink {
                BallPositionAdvice(advice: advice)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    Text("Ball Position Advice")
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 30)
                .foregroundColor(.init(UIColor(red: 0, green: 87 / 255, blue: 23 / 255, alpha: 1)))
            }
            Spacer()
        }    }
}


