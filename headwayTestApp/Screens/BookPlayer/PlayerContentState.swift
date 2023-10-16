//
//  PlayerContentState.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

enum PlayerContentState {
    case player
    case text

    mutating func toggle() {
        switch self {
        case .player:
            self = .text

        case .text:
            self = .player
        }
    }
}
