//
//  ContentView.swift
//  LevelLogTest
//
//  Created by JeongHyun Kim on 1/22/24.
//

import SwiftUI
import LevelOSLog

struct ContentView: View {
    var body: some View {
        VStack {
            MyView()
        }
        .padding()
        .onAppear() {
            LLog.shared.changeLevel(levels: [.debug,.network,.error])
        }
    }
}

#Preview {
    ContentView()
}
