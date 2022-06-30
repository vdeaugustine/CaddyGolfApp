//
//  LabelForClub.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/29/22.
//

import SwiftUI

struct LabelForClub: View {
    var club: Club
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(club.getName().capitalized)
                .font(.system(size: 30))
            
                .padding(.leading, 20)
            Text("\(club.getDistance()) yards")
                .font(.title2)
                .padding([.leading])
        }
        .padding()
    }
}
