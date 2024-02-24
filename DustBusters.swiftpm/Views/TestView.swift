//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct TestView: View {
    @State private var drawingErasing: Bool = false
    let startPosition: CGPoint
    var body: some View {
        Path { path in
            path.move(to: startPosition)
            
            path.moveAndDrawLine(-100, 0)
            path.moveAndDrawLine(-50, 50)
            path.moveAndDrawLine(-80, -100)
            
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            
            path.moveAndDrawLine(-50, 50)
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
