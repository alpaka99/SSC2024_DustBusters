//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/22/24.
//

import SwiftUI

struct SkyLineView: BuildingView {
    @State internal var startingPoint: CGPoint = getCurrentStartingPoint()
    @Binding var buildingColor: Color
    
    var body: some View {
        Path { path in
            path.move(to: startingPoint)
            
            path.moveAndDrawLine(0, -650)
            
            // Building 1
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -40)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -40)
            path.moveAndDrawLine(15, -30)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(10, 0)
            
            path.moveAndDrawLine(0, 20) // Building 1 center
            
            path.moveAndDrawLine(15, 30)
            path.moveAndDrawLine(0, 40)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 60)
            path.moveAndDrawLine(80, 20)
            path.moveAndDrawLine(0, 300)
            
            // Bridge 1
            path.moveAndDrawLine(40, 0)
            
            // Building 2
            path.moveAndDrawLine(0, -300)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -40)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -80)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -60)
            
            path.moveAndDrawLine(10, 0) // building6 center
            
            path.moveAndDrawLine(0, 60)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(40, 40)
            path.moveAndDrawLine(0, 60)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(20, 20)
            path.moveAndDrawLine(0, 100)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 10)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 100)
            
            // Bridge 2
            path.moveAndDrawLine(40, 0)
            
            // Building 3
            path.moveAndDrawLine(0, -300)
            path.moveAndDrawLine(60, 0)
            path.moveAndDrawLine(0, -10)
            path.moveAndDrawLine(30, 0)
            path.moveAndDrawLine(0, 10)
            path.moveAndDrawLine(10, 0)
            path.moveAndDrawLine(0, 300)
            
            // Bridge 3
            path.moveAndDrawLine(70, 0)
            
            // Building 4
            path.moveAndDrawLine(0, -200)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -20)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, -50)
            
            path.moveAndDrawLine(10, 0) // building 4 center
            
            path.moveAndDrawLine(0, 50)
            path.moveAndDrawLine(20, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 20)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 250)
            
            // bridge 4
            path.moveAndDrawLine(20, 0)
            
            // building 5
            path.moveAndDrawLine(0, -200)
            path.moveAndDrawLine(100, -50)
            
            path.moveAndDrawLine(50, 0) // Building 5 center
            
            path.moveAndDrawLine(0, 400)
            
            // bridge 5
            path.moveAndDrawLine(40, 0)
            
            // building 6
            path.moveAndDrawLine(0, -400)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -30)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -30)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, -50)
            
            path.moveAndDrawLine(10, 0) // building 2 center
            
            path.moveAndDrawLine(0, 50)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 30)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 30)
            path.moveAndDrawLine(15, 0)
            path.moveAndDrawLine(0, 300)
            
            // bridge 6
            path.moveAndDrawLine(40, 0)
            
            // building 7
            path.moveAndDrawLine(0, -300)
            path.moveAndDrawLine(40, -40)
            path.moveAndDrawLine(200, 0)
            
            
            
            // ending path
            path.drawHorizontalLine()
            path.closeSubpath()
        }
        .fill(buildingColor)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { value in
            startingPoint = NeighborhoodView.getCurrentStartingPoint()
        }
    }
}

struct SkyLineView_Preview: PreviewProvider {
    static var previews: some View {
        SkyLineView(buildingColor: .constant(.blue))
    }
}
