//
//  ContentView.swift
//  IdDrop
//
//  Created by dai.higuchi on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(snsClass())
    }
}
