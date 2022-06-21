//
//  AdviceAnswerView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/19/22.
//

import SwiftUI

struct AdviceAnswerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline) {
                Text("Recommendation")
                    .font(.title)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.75)
                Spacer()
                Button("Explanation") {}
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .padding()
            Text("Club name - Club Type Swing")
                .font(.title2)
                .padding()
            Text("Club average yardage")
                .padding()
                .padding([.leading])
            GeometryReader { geo in
                HStack {
                    Circle()
                        .frame(width: geo.size.width / 2)

                    Text("FIR%")
                        .font(.system(size: geo.size.width * 0.1))
                        .padding([.leading], geo.size.width * 0.15)
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .padding([.leading], 20)
            }
            
            List {
                Section {
                    
                    ForEach(1..<12) { n in
                        Text("\(n)")
                    }
                    
                } header: {
                    Text("Club Notes")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            } .listStyle(.sidebar)
        }
    }
}

struct AdviceAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AdviceAnswerView()
            .preferredColorScheme(.dark)
    }
}
