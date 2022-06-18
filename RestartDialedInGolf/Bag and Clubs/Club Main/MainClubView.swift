//
//  MainClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/17/22.
//

import SwiftUI
import LineChartView

struct SidewaysText: View {
    @State private var size = CGSize.zero
    var text: String
    var body: some View {
        Text(text)
            .fixedSize() // << important !!
            .background(GeometryReader {
                Color.clear
                    .preference(key:ViewSizeKey.self, value: $0.frame(in: .local).size)
            })
            .onPreferenceChange(ViewSizeKey.self) {
                self.size = $0 // << here !!
            }
            .rotationEffect(.degrees(270))
            .frame(width: size.height, height: size.width) // << here !!
            .foregroundColor(.black)
    }
}





struct LineChartForSwings: View {
    
    var club: Club
    
    private var data: [LineChartData] {
        
        var retArr = [LineChartData]()
        
        for swing in club.getSwings() {
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



struct ViewSizeKey: PreferenceKey {
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
    
    static var defaultValue: Value = .zero
}

struct MainClubView: View {
    var club: Club
    var body: some View {
        ScrollView {
            VStack {
                Section {
                    LineChartForSwings(club: club)
                } header: {
                    Text("Charts")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.medium)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                } label: {
                    Text("Add Stroke")
                }
            }
        }
    }
}

struct MainClubView_Previews: PreviewProvider {
    static let club = Club(number: "7", type: .iron, name: "7 iron", distance: 158)
    static var previews: some View {
        MainClubView(club: club)
            .preferredColorScheme(.dark)
    }
}
