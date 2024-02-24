//
//  File.swift
//  
//
//  Created by user on 2/23/24.
//

import Foundation
import SwiftUI

extension Path {
    var currentX: CGFloat {
        if let currentPoint = self.currentPoint {
            return currentPoint.x
        } else {
            return 0
        }
    }
    
    var currentY: CGFloat {
        if let currentPoint = self.currentPoint {
            return currentPoint.y
        } else {
            return 0
        }
    }
    
    mutating func conveninceAddLine(_ x: CGFloat, _ y: CGFloat) {
        self.addLine(to: CGPoint(x: x, y: y))
    }
    
    
    mutating func moveAndDrawLine(_ x: CGFloat, _ y: CGFloat) {
        self.addLine(to: CGPoint(
            x: self.currentX + x,
            y: self.currentY + y
        ))
    }
    
    mutating func drawParellelLine(_ x: CGFloat) {
        self.addLine(to: CGPoint(x: 0, y: self.currentY))
    }
    
    mutating func drawHorizontalLine() {
        self.addLine(to: CGPoint(x: self.currentX, y: Constants.screenHeight))
    }
    
    mutating func drawClockwiseQuadCircle(_ type: Quadrant ,_ radius: CGFloat) {
        
        var startAngle: Double = 0
        var endAngle: Double = 0
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        
        switch type {
        case .quadrant1:
            startAngle = -90
            endAngle = 0
            centerX = self.currentX
            centerY = self.currentY + radius
        case .quadrant2:
            startAngle = 0
            endAngle = 90
            centerX = self.currentX - radius
            centerY = self.currentY
        case .quadrant3:
            startAngle = 90
            endAngle = 180
            centerX = self.currentX
            centerY = self.currentY - radius
        case .quadrant4:
            startAngle = 180
            endAngle = 270
            centerX = self.currentX + radius
            centerY = self.currentY
        }
        
        self.addArc(
            center: CGPoint(
                x: centerX,
                y: centerY
            ),
            radius: radius,
            startAngle: Angle(degrees: startAngle),
            endAngle: Angle(degrees: endAngle),
            clockwise: false
        )
    }
    
    
//    mutating func drawAntiClockwiseQuadCircle(_ type: Quadrant ,_ radius: CGFloat) {
//        
//        var startAngle: Double = 0
//        var endAngle: Double = 0
//        var centerX: CGFloat = 0
//        var centerY: CGFloat = 0
//        
//        switch type {
//        case .quadrant1:
//            startAngle = -90
//            endAngle = 0
//            centerX = self.currentX
//            centerY = self.currentY + radius
//        case .quadrant2:
//            startAngle = 0
//            endAngle = 90
//            centerX = self.currentX - radius
//            centerY = self.currentY
//        case .quadrant3:
//            startAngle = 90
//            endAngle = 180
//            centerX = self.currentX
//            centerY = self.currentY - radius
//        case .quadrant4:
//            startAngle = 180
//            endAngle = 270
//            centerX = self.currentX + radius
//            centerY = self.currentY
//        }
//        
//        self.addArc(
//            center: CGPoint(
//                x: centerX,
//                y: centerY
//            ),
//            radius: radius,
//            startAngle: Angle(degrees: endAngle),
//            endAngle: Angle(degrees: startAngle),
//            clockwise: false
//        )
//    }
    
    enum Quadrant {
        case quadrant1, quadrant2, quadrant3, quadrant4
    }
}
