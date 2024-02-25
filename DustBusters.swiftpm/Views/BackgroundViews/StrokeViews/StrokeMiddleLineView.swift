//
//  SwiftUIView.swift
//
//
//  Created by user on 2/24/24.
//

import SwiftUI

struct StrokeMiddleLineView: BuildingView {
    @State var startingPoint: CGPoint = getCurrentStartingPoint()
    @Binding var buildingColor: Color
    @State private var drawingErasing: Bool = false
    
    
    var body: some View {
        Path { path in
            path.move(to: startingPoint)
            
            // building 1
            path.moveAndDrawLine(0, -100)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -200)
            path.moveAndDrawLine(100, 0)
            path.moveAndDrawLine(0, 250)
            
            // bridge 1
            path.moveAndDrawLine(40, 0)
            
            
            // building 2
            path.moveAndDrawLine(0, -500)
            path.moveAndDrawLine(120, 0)
            path.moveAndDrawLine(0, 40)
            path.moveAndDrawLine(40, 0)
            path.moveAndDrawLine(0, 400)
            
            // bridge 3
            path.moveAndDrawLine(20, 0)
            
            // building 3
            path.moveAndDrawLine(0, -250)
            path.moveAndDrawLine(30, -30)
            path.moveAndDrawLine(50, 0)
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(60, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(30, 0)
            path.moveAndDrawLine(0, 200)
            
            // bridge 3
            path.moveAndDrawLine(20, 0)
            
            // building4
            path.moveAndDrawLine(0, -200)
            path.moveAndDrawLine(100, 0)
            path.moveAndDrawLine(0, 400)
            
            // bridge 4
            path.moveAndDrawLine(40, 0)
            
            // building 5
            path.moveAndDrawLine(0, -300)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, -10)
            path.moveAndDrawLine(100, 0)
            path.moveAndDrawLine(0, 10)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 300)
            
            // bridge 5
            path.moveAndDrawLine(40, 0)
            
            // building 6
            path.moveAndDrawLine(0, -250)

            path.moveAndDrawLine(-15, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(-10, 0)
            path.moveAndDrawLine(0, -40)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, -20)
            
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 10)
            
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(10, -100)
            path.moveAndDrawLine(10, 100)
            path.moveAndDrawLine(10, 0)
            
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 40)
            path.moveAndDrawLine(-10, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(-15, 0)
            
            path.moveAndDrawLine(0, 250)
            
            // bridge 6
            path.moveAndDrawLine(40, 0)
            
            // building 7
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(0, -60)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(0, -100)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, -60)
            path.moveAndDrawLine(10, 0)
            
            path.moveAndDrawLine(20, -150) // tower 1
            path.moveAndDrawLine(20, 150)
            
            path.moveAndDrawLine(10, 0) // center
            path.moveAndDrawLine(0, 50)
            
            path.moveAndDrawLine(40, -60) // tower 2
            path.moveAndDrawLine(40, 60)
            
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(10, 0)
            
            path.moveAndDrawLine(20, -150)
            path.moveAndDrawLine(20, 150)
            
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 60)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 100)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(0, 60)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(0, 50)
            path.moveAndDrawLine(5, 0)
            path.moveAndDrawLine(40, 0)
            
            // ending
            path.drawHorizontalLine()
            path.closeSubpath()
        }
        .animatedPathDraw(
            from: drawingErasing ? 0 : 1,
            to: 1,
            lineWidth: 3
        )
        .onAppear {
            withAnimation(
                .easeOut(duration: 2)
                .delay(1)
                .repeatForever(autoreverses: false)) {
                drawingErasing.toggle()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { value in
            startingPoint = MiddleLineView.getCurrentStartingPoint()
        }
    }
}

struct StrokeMiddleLineView_Preview: PreviewProvider {
    static var previews: some View {
        MiddleLineView(
            buildingColor: .constant(.orange)
        )
    }
}

