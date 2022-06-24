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
    var valuesForChart: ([Double], [String]) {
        var retDoubleArr = [Double]()
        var retStrArr = [String]()
        if club.getSwings(ofType: .left).count > 0 {
            retDoubleArr.append(Double(club.getSwings(ofType: .left).count))
            retStrArr.append("Left")
        }
        if club.getSwings(ofType: .straight).count > 0 {
            retDoubleArr.append(Double(club.getSwings(ofType: .straight).count))
            retStrArr.append("Straight")
        }
        if club.getSwings(ofType: .right).count > 0 {
            retDoubleArr.append(Double(club.getSwings(ofType: .right).count))
            retStrArr.append("Right")
        }
            
        return (retDoubleArr, retStrArr)
    }
    
    var doShow: Bool {
        let oneOrMoreLeftSwings = club.getSwings(ofType: .left).count > 0
        let oneOrMoreStraightSwings = club.getSwings(ofType: .straight).count > 0
        let oneOrMoreRightSwings = club.getSwings(ofType: .left).count > 0
        return oneOrMoreLeftSwings || oneOrMoreRightSwings || oneOrMoreStraightSwings
    }
    var body: some View {
        
        if doShow {
            PieChartView(values: valuesForChart.0, names: valuesForChart.1, formatter: { "\(Int($0)) swings" }, backgroundColor: .black)
            .padding()
            
            
        }
        else {
            
            VStack {
                NoSwingsIndicator()
                
                PieChartView(values: (1...3).map({ _ in Double.random(in: 5...15)}),
                             names: ["Left", "Straight", "Right"], formatter: { "\(Int($0)) swings" }, backgroundColor: .black)
                
            }
            
        }
        
        
    }
}

struct PieChart_Previews: PreviewProvider {
    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
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
        } .frame(height: 35)
    }
}
