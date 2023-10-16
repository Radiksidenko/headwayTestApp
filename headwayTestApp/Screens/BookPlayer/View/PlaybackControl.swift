//
//  PlaybackControl.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlaybackControl: View {
    let viewStore: ViewStore<BookPlayerReducer.State, BookPlayerReducer.Action>
    
    var body: some View {
        HStack(spacing: 44) {
            PlaybackControlButton(icon: "backward.end.fill", color: .gray) {
                viewStore.send(.previousTrack)
            }
            
            PlaybackControlButton(icon: "gobackward.10") {
                viewStore.send(.gobackward)
            }
            
            PlaybackControlButton(icon: viewStore.isPLaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 44) {
                viewStore.send(.playPause)
            }
            
            PlaybackControlButton(icon: "goforward.10") {
                viewStore.send(.goforward)
            }
            
            PlaybackControlButton(icon: "forward.end.fill") {
                viewStore.send(.nextTrack)
            }
        }
    }
}
