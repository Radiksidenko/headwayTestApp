//
//  PlayerComponnent.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 11.10.2023.
//

import Foundation
import SwiftUI

struct PlaceholderImage: View {
    var buttonSize = 30.0
    var title: String
    var description: String
    var secondDescription: String = ""
    var imageString: String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: .zero) {
            Image(imageString)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(height: 300, alignment: .center)
                .padding(.top, 30)
//                .onAppear {
//                    self.displayData.fetchImage { image in
//                        self.bookImage = image
//                    }
//                }
            
            Text(description)
                .font(.system(size: 19))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Text(title)
                .font(.system(size: 25, weight: .semibold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 60)
            
            if !secondDescription.isEmpty {
                Text(secondDescription)
                    .font(.system(size: 19))
                    .multilineTextAlignment(.center)
                    .frame(height: 45.0)
            }
        }
    }
}
