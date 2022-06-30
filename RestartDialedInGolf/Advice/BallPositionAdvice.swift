//
//  BallPositionAdvice.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/27/22.
//

import SwiftUI

struct BallPositionAdvice: View {
    let advice: Advice
    var adviceArray: [String] {
        switch advice.ballPosition {
        case .flat:
            return [String]()
        case .downhill:
            return Advice.adviceForLie.downhill
        case .uphill:
            return Advice.adviceForLie.uphill
        case .belowFeet:
            return Advice.adviceForLie.ballBelowFeet
        case .aboveFeet:
            return Advice.adviceForLie.ballAboveFeet
        }
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(adviceArray, id: \.self) { piece in
                    Text("- " + piece)
                        .padding(.top)
                    
                }
                Spacer()
                        
                    } .navigationTitle("Position: " + advice.ballPosition.rawValue.capitalized)
                        .navigationBarTitleDisplayMode(.large)
            Spacer()
        }
        .padding(.leading, 30)
        .padding(.top)
        
    }
        
        
}

struct BallPositionAdvice_Previews: PreviewProvider {
    static var advice = Advice(closestClub: Club(number: "140", type: .hybrid, name: "2 Hybrid", distance: 240), secondClosestClub: Club(number: "4", type: .iron, name: "4 iron", distance: 189), typeOfShot: .fairwayShot, ballPosition: .downhill)
    static var previews: some View {
        BallPositionAdvice(advice: advice)
    }
}
