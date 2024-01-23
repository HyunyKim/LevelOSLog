//
//  MyView.swift
//  LevelLogTest
//
//  Created by JeongHyun Kim on 1/23/24.
//

import SwiftUI
import LevelOSLog

struct MyView: View {
    
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 50, content: {
            PlayerVIew(episode: Episode(title: "NewJeans - ETA"))
            
            Button(isPlaying ? "MyView Playing" : "MyView Pause") {
                Log.network("MyView isPlaying", isPlaying)
                isPlaying.toggle()
            }
        })
    }
}

#Preview {
    MyView()
}
