//
//  Constants.swift
//  DustBusters
//
//  Created by user on 2/18/24.
//

import Foundation
import SwiftUI
import UIKit

struct Constants {
    struct ScalableObject: Hashable {
        let id: UUID = UUID()
        let imageName: String
        let initialSize: CGFloat
        let opacity: Double
    }
    
    
    static let scalableObjects: [ScalableObject] = [
        appleObject,
        coffeeObject,
        waterObject,
        saltObject,
        twodustsObject,
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        ScalableObject.init(dummy: true),
        
    ]
    
    internal static let appleImageName: String = "apple"
    internal static let coffeebeanImageName: String = "coffeebean"
    internal static let waterImageName: String = "water"
    internal static let saltImageName: String = "salt"
//    internal static let microdustImageName: String = "microdust"
    internal static let twodustsImageName: String = "twodusts"

    // 나누기 40 스케일
    private static let appleObject: ScalableObject = ScalableObject(
        imageName: appleImageName,
        initialSize: 420,
        opacity: 1
    )
    private static let coffeeObject: ScalableObject = ScalableObject(
        imageName: coffeebeanImageName,
        initialSize: 210,
        opacity: 1
    )
    private static let waterObject: ScalableObject = ScalableObject(
        imageName: waterImageName,
        initialSize: 20,
        opacity: 1
    )
    private static let saltObject: ScalableObject = ScalableObject(
        imageName: saltImageName,
        initialSize: 5,
        opacity: 1
    )
    private static let twodustsObject: ScalableObject = ScalableObject(
        imageName: twodustsImageName,
        initialSize: 0.6,
        opacity: 1
    )
    
    internal static let screenWidth: CGFloat = UIScreen.main.bounds.maxX
    
    internal static let screenHeight: CGFloat = UIScreen.main.bounds.maxY
    
    
    public enum NavigationValue: String {
        case homeView, sizeCompareView, arView, microDustEffectView, swipeView, endingView
    }
    
    public enum appStates {
        case initial
        case halfway
        case clear
    }
    
    static var appState: appStates = .initial
}


