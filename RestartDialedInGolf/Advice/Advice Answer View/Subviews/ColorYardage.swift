//
//  ColorYardage.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct ColorYardage: View {
    let advice: Advice
    let club: Club
    let color: Color
    var backColor: Color {
        if color == .red {
            return .init(UIColor(red: 0 / 255, green: 32 / 255, blue: 87 / 255, alpha: 1))
        }
        if color == .green {
            return .init(UIColor(red: 0, green: 87 / 255, blue: 23 / 255, alpha: 1))
        }
        return .clear
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            LabelForClub(club: club)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backColor)
                if let realDistance = advice.realDistance {
                    let inFront: String = club.getDistance() - realDistance >= 0 ? "+" : "-"
                    Text(inFront + "\(abs(club.getDistance() - realDistance))")
                        .foregroundColor(.green)
                        .fontWeight(.medium)
                }
            }
            .frame(width: 60, height: 40)
        }
    }
}
