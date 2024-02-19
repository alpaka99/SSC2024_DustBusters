//
//  Constants.swift
//  DustBusters
//
//  Created by user on 2/18/24.
//

import Foundation

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
    ]
    
    private static let appleImageName: String = "apple"
    private static let coffeebeanImageName: String = "coffeebean"
    private static let waterImageName: String = "water"
    private static let saltImageName: String = "salt"
    private static let microdustImageName: String = "microdust"
    private static let twodustsImageName: String = "twodusts"

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
}

extension Constants.ScalableObject {
    init(dummy: Bool) {
        self.imageName = Constants.microdustImageName
        self.initialSize = 10
        self.opacity = 0.001
    }
}
