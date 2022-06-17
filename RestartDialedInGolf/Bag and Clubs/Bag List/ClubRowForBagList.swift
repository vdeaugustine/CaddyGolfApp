//
//  ClubRowForBagList.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct CircleForStrokes: Shape {
    //    var color: Color
    var strokes: Double = 23
    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: CGPoint(x: 25, y: 25), radius: 24, startAngle: .degrees(270), endAngle: .degrees(Double(270) - Double(360) * (strokes / 25)), clockwise: true)

        return p.strokedPath(.init(lineWidth: 3))
    }
}

struct ClubRowForBagList: View {
    var club: Club
    var body: some View {
        HStack {
            Button {
                print("tapped")
            } label: {
                ZStack {
                    CircleForStrokes(strokes: 25)
                        .foregroundColor(.white)
                    CircleForStrokes(strokes: Double(club.getSwings().count))
                        .foregroundColor(.blue)

                    Text("Strokes")
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .frame(width: 40)

                }.frame(width: 50, height: 50)

            }.buttonStyle(PlainButtonStyle())

            Text(club.getName())
                .font(.title2)
                .bold()
                .padding(5)

            Spacer()

            Text("\(club.getDistance()) yards")
                .font(.headline)
            
            Image(systemName: "chevron.right")
                .padding([.trailing])
            
        }
        .frame(height: 60)
    }
}

struct ClubRowForBagList_Previews: PreviewProvider {
    static let clubPreveiw: Club = {
        var c = Club(number: "3",
                     type: .iron,
                     name: "3 iron",
                     distance: 180)
        for i in 1...60 {
            c.addSwing(Swing(distance: Int.random(in: 180...215), direction: SwingDirection.allCases.randomElement()!))
        }
        return c
    }()

    static var previews: some View {
        ClubRowForBagList(club: clubPreveiw)
            .previewLayout(.fixed(width: 400, height: 150))
            .preferredColorScheme(.dark)
    }
}
