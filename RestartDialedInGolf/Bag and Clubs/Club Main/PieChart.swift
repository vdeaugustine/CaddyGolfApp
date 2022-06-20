//
//  PieChart.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/18/22.
//
import SwiftPieChart
import SwiftUI

struct PieChart: View {
    var club: Club
    var body: some View {
        PieChartView(values: [
            Double(club.getSwings(ofType: .left).count > 0 ? club.getSwings(ofType: .left).count : 1),
            Double(club.getSwings(ofType: .straight).count > 0 ? club.getSwings(ofType: .straight).count : 1),
            Double(club.getSwings(ofType: .right).count > 0 ? club.getSwings(ofType: .right).count : 1),
        ], names: ["Left", "Center", "Right"], formatter: { "\(Int($0)) swings" }, backgroundColor: .black)
        .padding()
    }
}

struct PieChart_Previews: PreviewProvider {
    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
    static var previews: some View {
        PieChart(club: club)
    }
}
