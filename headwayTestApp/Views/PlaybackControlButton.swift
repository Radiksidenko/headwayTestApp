//
//  PlaybackControlButton.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI

struct PlaybackControlButton: View {
    var icon: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .black
    var action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }
    }
}
