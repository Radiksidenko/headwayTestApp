//
//  BookPlayerReducer.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 15.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct BookPlayerReducer: ReducerProtocol {
    
    var audioManager: AudioManager = .init()
    
    struct State: Equatable {
        var book: Book?
        var mode: PlayerContentState = .player
        var isPLaying: Bool = false
        var current: Double = .zero
        var duration: Double = .zero
        
        var rateButtonTitle = "Speed 1x"
        var currentRate: Float = 1
    }
    
    enum Action: Equatable {
        case changeMode
        case playPause
        case play
        case pause(Bool)
        case startPlayer
        case progressUpdatedByUser(Double)
        case progressUpdatedByCurrentTime
        case editingSlider(Bool)
        
        case nextTrack
        case previousTrack
        case gobackward
        case goforward
        case changeRate
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        
        switch action {
            
        case .play:
            audioManager.play()
            state.isPLaying = audioManager.isPlaying
        case .pause(let changeStatus):
            audioManager.pause()
            state.isPLaying = changeStatus ? audioManager.isPlaying : state.isPLaying
            
        case .startPlayer:
            if let content = state.book?.content {
                
                audioManager.startPlayer(content: content)
                state.duration = audioManager.duration
            }
       
        case .playPause:
            audioManager.playPause()
            state.isPLaying = audioManager.isPlaying
        
        case .editingSlider(let editing):
            if editing {
                return reduce(into: &state, action: .pause(false))
            } else {
                if state.isPLaying {
                    return reduce(into: &state, action: .play)
                }
            }
        case .changeMode:
            state.mode.toggle()
            print("add logic")
            return reduce(into: &state, action: .pause(true))
        
        case .progressUpdatedByCurrentTime:
            state.current = audioManager.currentTime
            
        case .progressUpdatedByUser(let progress):
            state.current = progress
            audioManager.setProgress(progress)
        case .nextTrack, .previousTrack:
            print("add logic")
            return .none
        case .gobackward:
            audioManager.gobackward()
            state.current = audioManager.currentTime
        case .goforward:
            audioManager.goforward()
            state.current = audioManager.currentTime
        case .changeRate:
            state.currentRate = state.currentRate == 2 ? 1 : state.currentRate + 0.25
//            state.currentRate += 0.25 //For Fun 😅
            state.rateButtonTitle = "Speed \(state.currentRate)x"
            audioManager.change(rate: state.currentRate)
        }
        return .none
    }
}
