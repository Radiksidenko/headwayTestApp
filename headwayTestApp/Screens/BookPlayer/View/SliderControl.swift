//
//  SliderControl.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct SliderControl: View {
    let viewStore: ViewStore<BookPlayerReducer.State, BookPlayerReducer.Action>
    
    var body: some View {
        VStack(spacing: 5) {
            Slider(value: viewStore.binding(
                get: \.current,
                send: BookPlayerReducer.Action.progressUpdatedByUser
            ), in: .zero ... viewStore.duration) { editing in
                viewStore.send(.editingSlider(editing))
            }
            .tint(.blue)
            
            HStack {
                Text(viewStore.current.timeFormat).foregroundColor(.black)
                Spacer()
                Text(viewStore.duration.timeFormat).foregroundColor(.black)
            }
            .font(.caption)
            .foregroundColor(.white)
            
            BaseButton(action: {
                viewStore.send(.changeRate)
            }, content: {
                HStack {
                    Text(viewStore.rateButtonTitle)
                        .padding(10.0)
                        .background(Color.gray)
                        .cornerRadius(6)
                        .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 20)
            })
        }
    }
}
