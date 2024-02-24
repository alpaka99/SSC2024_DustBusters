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
            path.moveAndDrawLine(10, 0)
            
            // house 1
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(-10, 0)
            path.moveAndDrawLine(50, -50)
            
            path.moveAndDrawLine(40, 0) // house 1 center
            
            path.moveAndDrawLine(15, 15)
            path.moveAndDrawLine(0, -10)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(25, 25)
            path.moveAndDrawLine(-10, 0)
            path.moveAndDrawLine(0, 50)
            
            // bridge 1
            path.moveAndDrawLine(30, 0)
            
            // tree 1
            // stem left
            path.moveAndDrawLine(0, -75)
            
            // leaf1
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            
            // leaf2
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            
            // leaf3
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 20)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            
            // laef4
            
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            
            // stem right
            path.moveAndDrawLine(0, 75)
            
            // Bridge 2
            path.moveAndDrawLine(40, 0)
            
            // house 2
            path.moveAndDrawLine(0, -150)
            path.moveAndDrawLine(75, 0)
            path.moveAndDrawLine(0, 150)
            
            // bridge 3
            path.moveAndDrawLine(80, 0)
            
            // tree 2
            path.moveAndDrawLine(0, -50)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant3, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 15)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 15)
            path.drawClockwiseQuadCircle(.quadrant1, 5)
            path.drawClockwiseQuadCircle(.quadrant4, 10)
            path.drawClockwiseQuadCircle(.quadrant1, 5)
            path.drawClockwiseQuadCircle(.quadrant4, 10)
            path.drawClockwiseQuadCircle(.quadrant1, 5)
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant1, 15)
            path.drawClockwiseQuadCircle(.quadrant1, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 15)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            
            // right stem
            path.moveAndDrawLine(0, 20)
            
            // bridge 3
            path.moveAndDrawLine(50, 0)
            
            // house 3
            path.moveAndDrawLine(0, -75)
            path.moveAndDrawLine(75, -32)
            path.moveAndDrawLine(30, 32)
            path.moveAndDrawLine(0, 75)
            
            // bridge 4
            path.moveAndDrawLine(50, 0)
            
            
            // tree 3
            // left stem
            path.moveAndDrawLine(0, -50)
            path.moveAndDrawLine(-20, 0)
            
            // leaves
            path.drawClockwiseQuadCircle(.quadrant3, 15)
            path.drawClockwiseQuadCircle(.quadrant4, 15)
            path.drawClockwiseQuadCircle(.quadrant3, 10)
            path.drawClockwiseQuadCircle(.quadrant4, 20)
            path.drawClockwiseQuadCircle(.quadrant4, 15)
            path.drawClockwiseQuadCircle(.quadrant1, 15)
            path.drawClockwiseQuadCircle(.quadrant1, 20)
            path.drawClockwiseQuadCircle(.quadrant2, 10)
            path.drawClockwiseQuadCircle(.quadrant1, 15)
            path.drawClockwiseQuadCircle(.quadrant2, 15)
            
            // right stem
            path.moveAndDrawLine(-20, 0)
            path.moveAndDrawLine(0, 50)
            
            // bridge 5
            path.moveAndDrawLine(40, 0)
            
            // building 6
            path.moveAndDrawLine(0, -70)
            path.moveAndDrawLine(30, -100)
            path.moveAndDrawLine(30, 100)
            path.moveAndDrawLine(100, 0)
            path.moveAndDrawLine(0, 70)
            
            // bridge 7
            path.moveAndDrawLine(40, 0)
            
            // building 7
            path.moveAndDrawLine(0, -60)
            path.moveAndDrawLine(40, -20)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -20)
            
            path.moveAndDrawLine(40, -40)
            path.moveAndDrawLine(40, 40)
            
            path.moveAndDrawLine(0, 100)
            
            // bridge 8
            path.moveAndDrawLine(60, 0)
            
            // tree 4
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(40, -150)
            path.moveAndDrawLine(40, 150)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(0, 20)
            
            // bridge 9
            path.moveAndDrawLine(100, 0)
            
            //tree 5
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(40, -150)
            path.moveAndDrawLine(40, 150)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(0, 20)
            
            // bridge 9
            path.moveAndDrawLine(100, 0)
            
            // tree 6
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(40, -150)
            path.moveAndDrawLine(40, 150)
            path.moveAndDrawLine(-50, 0)
            path.moveAndDrawLine(0, 20)
            
            
            
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
