//
//  Home.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 11.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct Home: View {
    var body: some View {
        HomeView(
            store: Store(
                initialState: HomeReducer.State(),
                reducer: { HomeReducer() }
            )
        )
    }
}
