//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct NeighborhoodView: BuildingView {
    @State internal var startingPoint: CGPoint = getCurrentStartingPoint()
    @State internal var buildingColor: Color
    
    var body: some View {
        Path { path in
            path.move(to: startingPoint)
            
            // bridge 0
            path.moveAndDrawLine(20, 0)
            
            // house 1
            path.moveAndDrawLine(0, -100)
            path.moveAndDrawLine(-20, 0)
            path.moveAndDrawLine(100, -100)
            
            path.moveAndDrawLine(80, 0) // house 1 center
            
            path.moveAndDrawLine(30, 30)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 40)
            path.moveAndDrawLine(50, 50)
            path.moveAndDrawLine(-20, 0)
            path.moveAndDrawLine(0, 100)
            
            // bridge 1
            path.moveAndDrawLine(60, 0)
            
            // tree 1
            // stem left
            path.moveAndDrawLine(0, -150)
            
            // leaf1
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 40)
            
            // leaf2
            path.drawClockwiseQuadCircle(.quadrant3, 40)
            path.drawClockwiseQuadCircle(.quadrant4, 40)
            path.drawClockwiseQuadCircle(.quadrant4, 40)
            path.drawClockwiseQuadCircle(.quadrant1, 40)
            
            // leaf3
            path.drawClockwiseQuadCircle(.quadrant4, 40)
            path.drawClockwiseQuadCircle(.quadrant1, 40)
            path.drawClockwiseQuadCircle(.quadrant1, 40)
            path.drawClockwiseQuadCircle(.quadrant2, 40)
            path.drawClockwiseQuadCircle(.quadrant1, 40)
            
            // laef4
            
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            
            // stem right
            path.moveAndDrawLine(0, 150)
            
            // Bridge 2
            path.moveAndDrawLine(40, 0)
            
            // house 2
            path.moveAndDrawLine(0, -300)
            path.moveAndDrawLine(150, 0)
            path.moveAndDrawLine(0, 300)
            
            // bridge 3
            path.moveAndDrawLine(80, 0)
            
            // tree 2
            path.moveAndDrawLine(0, -50)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant3, 40)
            path.drawClockwiseQuadCircle(.quadrant4, 30)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 30)
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 30)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 30)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            
            // right stem
            path.moveAndDrawLine(0, 40)
            
            // bridge 3
            path.moveAndDrawLine( 100, 0)
            
            // house 3
            path.moveAndDrawLine(0, -150)
            path.moveAndDrawLine(150, -75)
            path.moveAndDrawLine(60, 75)
            path.moveAndDrawLine(0, 150)
            
            // bridge 4
            path.moveAndDrawLine(100, 0)
            
            
            // tree 3
            // left stem
            path.moveAndDrawLine(0, -70)
            path.moveAndDrawLine(-40, 0)
            
            // leaves
            path.drawClockwiseQuadCircle(.quadrant3, 30)
            path.drawClockwiseQuadCircle(.quadrant4, 30)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 40)
            path.drawClockwiseQuadCircle(.quadrant4, 30)
            path.drawClockwiseQuadCircle(.quadrant1, 30)
            path.drawClockwiseQuadCircle(.quadrant1, 40)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 30)
            path.drawClockwiseQuadCircle(.quadrant2, 30)
            
            // right stem
            path.moveAndDrawLine(-40, 0)
            path.moveAndDrawLine(0, 70)
            
            //Ending
            path.drawHorizontalLine()
            path.closeSubpath()
        }
        .fill(buildingColor)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { value in
            startingPoint = NeighborhoodView.getCurrentStartingPoint()
        }
    }
}

struct NeighborhoodView_Preview: PreviewProvider {
    static var previews: some View {
        NeighborhoodView(buildingColor: .green)
    }
}
