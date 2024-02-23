//
//  File.swift
//  
//
//  Created by user on 2/24/24.
//

import SwiftUI
import Foundation

protocol EffectHelper {
    
}

final class HapticManager: EffectHelper {
    static var shared: HapticManager = HapticManager()
    
    enum HapticType {
        case soft, light, medium, heavy, rigid
    }
    
    func createHaptic(_ type: HapticType) {
        switch type {
        case .soft:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case .light:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .rigid:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        }
    }
}
