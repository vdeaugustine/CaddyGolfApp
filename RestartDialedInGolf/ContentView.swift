//
//  ContentView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    enum Tabs {
        case bag, notes, advice
    }
    var body: some View {
        TabView {
            NavigationView {
                BagListView()
                    .environmentObject(modelData)
                    .tabItem {
                       Image(systemName: "square")
                        Text("Bag")
                    }
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
