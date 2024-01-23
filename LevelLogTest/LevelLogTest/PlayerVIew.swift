//
//  PlayerVIew.swift
//  LevelLogTest
//
//  Created by JeongHyun Kim on 1/23/24.
//

import SwiftUI
import LevelOSLog

struct Episode {
    var title: String
}

struct PlayButton: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(isPlaying ? "Pause" : "Play") {
            Log.debug("PlayerBefore", isPlaying)
            isPlaying.toggle()
        }
    }
}

struct PlayerVIew: View {
    var episode: Episode
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack {
            Text(episode.title)
                .foregroundStyle(isPlaying ? .primary : .secondary)
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

#Preview {
    PlayerVIew(episode: Episode(title: "Sonata"))
}
