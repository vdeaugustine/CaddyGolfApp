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
    @EnvironmentObject var modelData: ModelData
    var modelClub: Club {
        guard let theClub = modelData.bag.clubs.first(where: { $0 == club }) else {
            return Club(number: "NA", type: .wood, name: "NA", distance: 999)
        }
        
        return theClub
    }

    var valuesForChart: ([Double], [String]) {
        var retDoubleArr = [Double]()
        var retStrArr = [String]()
        if modelClub.getSwings(ofType: .left).count > 0 {
            retDoubleArr.append(Double(modelClub.getSwings(ofType: .left).count))
            retStrArr.append("Left")
        }
        if modelClub.getSwings(ofType: .straight).count > 0 {
            retDoubleArr.append(Double(modelClub.getSwings(ofType: .straight).count))
            retStrArr.append("Straight")
        }
        if modelClub.getSwings(ofType: .right).count > 0 {
            retDoubleArr.append(Double(modelClub.getSwings(ofType: .right).count))
            retStrArr.append("Right")
        }

        return (retDoubleArr, retStrArr)
    }

    var doShow: Bool {
        let oneOrMoreLeftSwings = modelClub.getSwings(ofType: .left).count > 0
        let oneOrMoreStraightSwings = modelClub.getSwings(ofType: .straight).count > 0
        let oneOrMoreRightSwings = modelClub.getSwings(ofType: .right).count > 0
        return oneOrMoreLeftSwings || oneOrMoreRightSwings || oneOrMoreStraightSwings
    }

    var body: some View {
        if doShow {
            PieChartView(values: valuesForChart.0, names: valuesForChart.1, formatter: { "\(Int($0)) swings" }, backgroundColor: .black)
                .padding()
        } else {
            VStack {
                NoSwingsIndicator()

                PieChartView(values: (1 ... 3).map({ _ in Double.random(in: 5 ... 15) }),
                             names: ["Left", "Straight", "Right"], formatter: { "\(Int($0)) swings" }, backgroundColor: .black)
                .padding()
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    @State static var club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
    static var previews: some View {
        PieChart(club: club)
    }
}

struct NoSwingsIndicator: View {
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
            Text("This is sample data. You have not recorded any swings yet for this club")
                .minimumScaleFactor(0.01)
                .lineLimit(0)
        }.frame(height: 35)
    }
}
