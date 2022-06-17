//
//  RestartDialedInGolfApp.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

@main
struct RestartDialedInGolfApp: App {
    @StateObject var modelData: ModelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                
        }
    }
}
