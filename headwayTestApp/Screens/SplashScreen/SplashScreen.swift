//
//  SplashScreen.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 11.10.2023.
//

import SwiftUI

struct SplashScreen: View {
    
    enum Style {
        static let lineWidth: CGFloat = 30
        static let width: CGFloat = 220
        static let height: CGFloat = 130
        static let scaleEffectStart: CGFloat = 0.9
        static let scaleEffectEnd: CGFloat = 0.15
        static let rotationDegrees: CGFloat = 85
    }
    
    
    @State  var startanimation: Bool = false
    @Binding var endanimated :Bool
    
    var body: some View {
        ZStack{
            Color("SplashColor")
            Group{
                HPath()
                    .trim(from: .zero, to: startanimation ? 1 : 0 )
                    .stroke(
                        Color.white,
                        style: StrokeStyle(
                            lineWidth: Style.lineWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
            }
            .frame(width: Style.width, height: Style.height)
            .scaleEffect(endanimated ? Style.scaleEffectEnd : Style.scaleEffectStart)
            .rotationEffect(.init(degrees: endanimated ? Style.rotationDegrees : .zero))
        }
        .offset(y: endanimated ? -(UIScreen.main.bounds.height * 1.5) : .zero)
         .ignoresSafeArea()
         .onAppear {
             
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                    withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 1.05, blendDuration: 1.05).delay(0.3)){
                        startanimation.toggle()
                    }
                    withAnimation(.interactiveSpring(response: 1.7, dampingFraction: 1.05, blendDuration: 1.05).delay(2.3)){
                        endanimated.toggle()
                    }
                }
            }
    }
   
}

struct HPath: Shape {
    
    private func getY(_ item: Int) -> CGFloat {
        let step = 50
        let lineHeight = 30
        
        return CGFloat((step * item) + lineHeight)
    }
    func path(in rect: CGRect) -> Path {
        
        let test: Path = Path { path in
            
            let mid = rect.width / 2
            let start = mid - 60
            let end = mid + 60
            let endY: CGFloat = 170
            
            path.move(to: CGPoint(x: start, y: .zero))
            path.addLine(to: CGPoint(x: start, y: endY))
            
            for item in 0...2 {
                path.move(to: CGPoint(x: start, y: getY(item)))
                path.addLine(to: CGPoint(x: end, y: getY(item)))
            }

            path.move(to: CGPoint(x: end, y: .zero))
            path.addLine(to: CGPoint(x: end, y: endY))
            
        }
        
        return test
    }
}
