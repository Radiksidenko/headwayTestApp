//
//  File.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI

struct BaseButton<Content: View>: View {
    
    let action: () -> Void
    var color: Color = .gray
    
    @ViewBuilder let content: Content
    
    var body: some View {
        Button(
            action: {
                action()
            }, label: {
                content
            }
        )
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(color)
        .cornerRadius(10)
    }
}
