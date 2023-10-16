//
//  ReadAndListen.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct ReadAndListen: View {
    
    enum Style {
        enum Icons {
            static let text: String = "text.alignleft"
            static let audio: String = "headphones"
            static let font: Font = .system(size: 17.0, weight: .semibold)
            static let spacing: CGFloat = 30.0
        }
        
        enum Background {
            static let color: Color = .white
            static let padding: CGFloat = 15.0
            static let cornerRadius: CGFloat = 6.0
        }
        
        enum IDs {
            static let text: Int = 0
            static let audio: Int = 1
        }
    }
    
    let viewStore: ViewStore<BookPlayerReducer.State, BookPlayerReducer.Action>
    @Namespace private var nameSpace
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 45)
                .matchedGeometryEffect(
                    id: viewStore.mode == .player ? Style.IDs.audio : Style.IDs.text,
                    in: nameSpace,
                    properties: .position,
                    anchor: .center,
                    isSource: false
                )

            HStack(spacing: Style.Icons.spacing) {
                Image(systemName: Style.Icons.text)
                    .font(Style.Icons.font)
                    .matchedGeometryEffect(id: Style.IDs.text, in: nameSpace)
                    .foregroundColor(viewStore.mode == .text ? .white : .black)
                Image(systemName: Style.Icons.audio)
                    .font(Style.Icons.font)
                    .matchedGeometryEffect(id: Style.IDs.audio, in: nameSpace)
                    .foregroundColor(viewStore.mode == .player ? .white : .black)
            }
            .padding(Style.Background.padding)
        }
        .animation(.easeInOut, value: viewStore.mode)
        .background {
            Capsule()
                .fill(.white)
        }
        .onTapGesture {
            viewStore.send(.changeMode)
        }
    }
}
