//
//  LineChartForSwings.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//

import SwiftUI
import LineChartView

struct LineChartForSwings: View {
    var club: Club
    @EnvironmentObject var modelData: ModelData
    var modelClub: Club {
        return modelData.bag.clubs.first(where: { $0 == club })!
    }
    private var data: [LineChartData] {
        var retArr = [LineChartData]()
        
        for swing in modelClub.getSwings() {
            
            retArr.append(LineChartData(Double(swing.distance),
                                        timestamp: swing.date,
                                        label: swing.direction.rawValue.uppercased()))
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
        
        LineChartView(lineChartParameters: chartParameters)
            .frame(height: 300)
    }
}
