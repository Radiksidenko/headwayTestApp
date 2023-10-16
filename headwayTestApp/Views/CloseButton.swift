//
//  CloseButton.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI

struct CloseButton: View {
    
    private enum Style {
        enum CloseButton {
            static let image = "xmark.circle.fill"
            static let font: Font = .system(size: 36)
            static let padding: CGFloat = 15.0
            static let color: Color = .black
        }
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: Style.CloseButton.image)
                    .font(Style.CloseButton.font)
                    .foregroundColor(Style.CloseButton.color)
            }
            .padding([.top, .leading], Style.CloseButton.padding)
        }
    }
}
