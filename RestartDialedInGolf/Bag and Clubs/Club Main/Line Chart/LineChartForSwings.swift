//
//  LineChartForSwings.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import LineChartView
import SwiftUI

struct LineChartForSwings: View {
    var club: Club
    @EnvironmentObject var modelData: ModelData
    var modelClub: Club {
        guard let theClub = modelData.bag.clubs.first(where: { $0 == club }) else {
            return Club(number: "NA", type: .wood, name: "NA", distance: 999)
        }
        
        return theClub
    }

    var doShow: Bool {
        let oneOrMoreLeftSwings = modelClub.getSwings(ofType: .left).count > 0
        let oneOrMoreStraightSwings = modelClub.getSwings(ofType: .straight).count > 0
        let oneOrMoreRightSwings = modelClub.getSwings(ofType: .right).count > 0
        return oneOrMoreLeftSwings || oneOrMoreRightSwings || oneOrMoreStraightSwings
    }

    private var data: [LineChartData] {
        var retArr = [LineChartData]()

        if doShow {
            for swing in modelClub.getSwings() {
                retArr.append(LineChartData(Double(swing.distance),
                                            timestamp: swing.date,
                                            label: swing.direction.rawValue.uppercased()))
            }
        } else {
            for _ in 0...25 {
                retArr.append(LineChartData(Double.random(in: Double(modelClub.getDistance() - 10) ..< Double(modelClub.getDistance() + 10)), label: SwingDirection.allCases.randomElement()!.rawValue.uppercased()))
            }
        }

        return retArr
    }

    var body: some View {
        let chartParameters = LineChartParameters(
            data: data,
            labelsAlignment: .center,
            dataPrecisionLength: 0,
            dataSuffix: " yards",
            hapticFeedback: true
        )

        VStack {
            if !doShow {
                NoSwingsIndicator()
            }

            LineChartView(lineChartParameters: chartParameters)
                .frame(height: 300)
                .padding(20)
        }
        
    }
}
