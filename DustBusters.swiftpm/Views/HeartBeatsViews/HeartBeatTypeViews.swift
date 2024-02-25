//
//  File.swift
//  
//
//  Created by user on 2/25/24.
//

import Foundation
import SwiftUI

struct NearDeathHeartBeatView : HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-100, 0)
            
            path.moveAndDrawLine(-10, 10)
            path.moveAndDrawLine(-10, -10)
            
            path.moveAndDrawLine(-100, 0)
            
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            
            path.moveAndDrawLine(-100, 0)
            
            path.move(to: startPosition)
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 1,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.nearDeath, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct SuperUnHealthyHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            
            path.moveAndDrawLine(-40, 0)
            
            path.moveAndDrawLine(-10, 10)
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            path.moveAndDrawLine(-10, -10)
            
            path.moveAndDrawLine(-60, 0)
       
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 1,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.superUnhealthy, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct UnHealthyHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-100, 0)
            
            path.moveAndDrawLine(-10, 20)
            path.moveAndDrawLine(-10, -20)
            path.moveAndDrawLine(-10, 20)
            path.moveAndDrawLine(-20, 0)
            path.moveAndDrawLine(-10, -30)
            path.moveAndDrawLine(-10, 30)
            path.moveAndDrawLine(-10, -20)
            
            path.moveAndDrawLine(-100, 0)
       
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 1,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.unHealthy, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct NormalHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-80, 0)
            
            path.moveAndDrawLine(-50, 25)
            path.moveAndDrawLine(-80, -50)
            path.moveAndDrawLine(-50, 25)
            
            path.moveAndDrawLine(-80, 0)
            
            path.move(to: startPosition)
            
            path.closeSubpath()
            
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 1,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.normal, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct SemiHealthyHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-100, 0)
            
            path.moveAndDrawLine(-20, -20)
            path.moveAndDrawLine(-40, 40)
            path.moveAndDrawLine(-20, -80)
            path.moveAndDrawLine(-20, 60)
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            
            path.moveAndDrawLine(-100, 0)
       
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 100,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.semiHealthy, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct HealthyHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            
            path.moveAndDrawLine(-20, 20)
            path.moveAndDrawLine(-20, -100)
            path.moveAndDrawLine(-20, 120)
            path.moveAndDrawLine(-20, -40)
            path.moveAndDrawLine(-20, 20)
            path.moveAndDrawLine(-20, -100)
            path.moveAndDrawLine(-20, 120)
            path.moveAndDrawLine(-20, -40)
            
            
            path.moveAndDrawLine(-60, 0)
       
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 100,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.healthy, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct SuperHealthyHeartBeatView: HeartBeatView {
    @State internal var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-100, 0)
            
            path.moveAndDrawLine(-30, 100)
            path.moveAndDrawLine(-20, -200)
            path.moveAndDrawLine(-20, 120)
            path.moveAndDrawLine(-20, -80)
            path.moveAndDrawLine(-20, 60)
            
            path.moveAndDrawLine(-100, 0)
            
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 100,
            lineWidth: 10
        )
        .onAppear {
            HapticManager.shared?.createHaptic(.superHealthy, true)
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}




struct HeartBeatsView_Preview: PreviewProvider {
    static var previews: some View {
        HeartBeatsView(counter: .constant(0), startPosition: .zero)
    }
}
