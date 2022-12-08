//
//  IdDropApp.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/04.
//

import SwiftUI

@main
struct IdDropApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(snsClass())
                .environmentObject(set())
        }
    }
}
