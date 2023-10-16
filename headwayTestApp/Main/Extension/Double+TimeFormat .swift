//
//  Double+TimeFormat .swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

extension Double {
    var timeFormat: String {
        let hours = Int(Int(self) / 3600)
        let minutes = Int(Int(self) % 3600 / 60)
        let seconds = Int((Int(self) % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
