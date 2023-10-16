//
//  Player_new.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 11.10.2023.
//

import SwiftUI
import Foundation
import AVKit

final class AudioManager: ObservableObject { //Add Protocol
    
    private var player: AVAudioPlayer?
    
    var isPlaying: Bool { player?.isPlaying ?? false }
    var duration: Double { player?.duration ?? 0 }
    var currentTime: Double { player?.currentTime ?? 0 }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func setProgress(_ time: Double) {
        player?.currentTime = time
    }
    
    func startPlayer(content: URL) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: content)
            
            player?.prepareToPlay()
            player?.enableRate = true
        } catch {
            print("Failer to initialize player: \(error)")
        }
    }
    
    func playPause() {
        
        guard let player = player else {
            print("No player")
            return
        }
        
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func gobackward() {
        player?.currentTime =  (player?.currentTime ?? 0) - 10
    }
    
    func goforward() {
        player?.currentTime =  (player?.currentTime ?? 0) + 10 //add step
    }
    
    func change(rate: Float) {
        player?.rate = rate
    }
    
    func stop() {
        guard let player = player else {
            print("No player")
            return
        }
        
        if player.isPlaying {
            player.stop()
        }
    }
}
