//
//  swingsCircles.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI

struct swingsCircles: View {
    var club: Club
    var body: some View {
        HStack {
            VStack {
                DistanceCircle(distance: Int(club.getDistance()))
                    .frame(width: 75, height: 75)
                Text("Average Yards")
            }
            .padding(.trailing, 50)
            Button {
            } label: {
                VStack {
                    StrokesCircle(strokes: CGFloat(club.getSwings().count), goalStrokes: 50)
                        .frame(width: 75, height: 75)
                    
                    Text("Strokes")
                }
                .padding(.leading, 50)
            }
            .tint(.white)
        }
        .padding()
        //        .navigationTitle("\(club.name)")
    }
}
