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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            
        }
    }
}

#Preview {
    ContentView()
}
