//
//  File.swift
//  
//
//  Created by user on 2/22/24.
//

import Foundation
import SwiftUI

protocol Building {
    //    var initialX: CGFloat { get }
    //    var initialY: CGFloat { get }
    var startingPoint: CGPoint { get }
    var buildingColor: Color { get set }
    
    static func getCurrentStartingPoint() -> CGPoint
    mutating func changeBuildingColor(to color: Color)
}

typealias BuildingView = Building & View

extension Building {
    static func getCurrentStartingPoint() -> CGPoint {
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        
        switch orientation {
        case let x where x == .portrait || x == .portraitUpsideDown:
            return CGPoint(x: 0, y: Constants.screenHeight)
        case let x where x == .landscapeLeft || x == .landscapeRight:
            return CGPoint(x: 0, y: Constants.screenWidth)
        default:
            return CGPoint(x: 0, y: Constants.screenHeight)
        }
    }
    
    mutating func changeBuildingColor(to color: Color) {
        buildingColor = color
    }
}
