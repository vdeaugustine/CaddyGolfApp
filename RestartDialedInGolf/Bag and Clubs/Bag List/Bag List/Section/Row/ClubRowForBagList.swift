//
//  ClubRowForBagList.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct ClubRowForBagList: View {
    // MARK: - Properties

    @EnvironmentObject var modelData: ModelData
    var club: Club
    var modelClub: Club {
        guard let theClub = modelData.bag.clubs.first(where: { $0 == club }) else {
            return Club(number: "NA", type: .wood, name: "NA", distance: 999)
        }

        return theClub
    }

    // MARK: - Body

    var body: some View {
        // MARK: Top level Hstack
        HStack {
            
            Button {
            } label: {
                // MARK: Strokes progress circles
                ZStack {
                    // Put one circle on top of the other. The bottom circle is the white circle that will always be there. The blue circle is only complete based on how many strokes the user has
                    CircleForStrokes(strokes: 25)
                        .foregroundColor(.white)
                    CircleForStrokes(strokes: Double(modelClub.getSwings().count))
                        .foregroundColor(.blue)

                    Text("Strokes")
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .frame(width: 40)

                }
                .frame(width: 50, height: 50)

            }
            .buttonStyle(PlainButtonStyle())

            // MARK: Club label
            Text(modelClub.getName())
                .font(.title2)
                .bold()
                .padding(5)
                .minimumScaleFactor(0.01)

            Spacer()

            // MARK: Distance label
            Text("\(modelClub.getDistance()) yards")
                .font(.headline)
                .minimumScaleFactor(0.01)
        }
        .frame(height: 60)
    }
}


// MARK: - Preview
struct ClubRowForBagList_Previews: PreviewProvider {
    static let clubPreveiw: Club = {
        var c = Club(number: "3",
                     type: .iron,
                     name: "3 iron",
                     distance: 180)
        for i in 1 ... 60 {
            c.addSwing(Swing(distance: Int.random(in: 180 ... 215), direction: SwingDirection.allCases.randomElement()!))
        }
        return c
    }()

    static var previews: some View {
        ClubRowForBagList(club: clubPreveiw)
            .previewLayout(.fixed(width: 400, height: 150))
            .preferredColorScheme(.dark)
    }
}
