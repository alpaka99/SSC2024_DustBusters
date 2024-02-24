//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct SemiHealthyBeatView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-80, 0)
            path.moveAndDrawLine(-50, 50)
            path.moveAndDrawLine(-80, -100)
            path.moveAndDrawLine(-50, 50)
            path.moveAndDrawLine(-80, 0)
            
            path.move(to: startPosition)
            
            path.closeSubpath()
            
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 100,
            lineWidth: 10
        )
        .onAppear {
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct HealthyView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            path.moveAndDrawLine(-30, 100)
            path.moveAndDrawLine(-20, -200)
            path.moveAndDrawLine(-20, 120)
            path.moveAndDrawLine(-20, -80)
            path.moveAndDrawLine(-20, 60)
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
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct UnHealthyView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            
            path.moveAndDrawLine(-10, 20)
            path.moveAndDrawLine(-10, -20)
            path.moveAndDrawLine(-10, 20)
            path.moveAndDrawLine(-10, -30)
            path.moveAndDrawLine(-10, 30)
            path.moveAndDrawLine(-10, -20)
            
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
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct NearDeathView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            
            path.moveAndDrawLine(-20, -10)
            path.moveAndDrawLine(-20, 10)
            path.moveAndDrawLine(-20, -10)
            path.moveAndDrawLine(-20, 10)
            
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
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}


struct SuperHealthyView: View {
    @State private var drawingErasing: Bool = false
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
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}


struct HmmView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-60, 0)
            
            path.moveAndDrawLine(-20, -20)
            path.moveAndDrawLine(-40, 40)
            path.moveAndDrawLine(-20, -80)
            path.moveAndDrawLine(-20, 60)
            path.moveAndDrawLine(-10, -10)
            path.moveAndDrawLine(-10, 10)
            
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
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}

struct TestView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(60, 0)
            
            path.moveAndDrawLine(20, -20)
            path.moveAndDrawLine(40, 40)
            path.moveAndDrawLine(20, -80)
            path.moveAndDrawLine(20, 60)
            path.moveAndDrawLine(10, -10)
            path.moveAndDrawLine(10, 10)
            
            path.moveAndDrawLine(60, 0)
       
            path.move(to: startPosition)
            
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 100,
            lineWidth: 10
        )
        .onAppear {
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
    }
}


struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TestView(startPosition: .zero)
    }
}
