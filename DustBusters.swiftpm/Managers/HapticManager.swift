//
//  File.swift
//  
//
//  Created by user on 2/24/24.
//

import CoreHaptics
import Foundation
import SwiftUI


protocol EffectHelper {
    
}

final class HapticManager: EffectHelper {
    static var shared: HapticManager? = HapticManager()
    
    private let hapticEngine: CHHapticEngine? = try? CHHapticEngine()
    private var hapticAdvancedPlayer: CHHapticAdvancedPatternPlayer? = nil
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        
        guard hapticCapability.supportsHaptics else {
            return nil
        }
    }
    
    enum HapticType {
        case soft, light, medium, heavy, rigid
    }
    
    enum HapticStyle {
        case rigidTwice
        case success
        case light(times: Int)
    }
    
    func stopHaptic() {
        do {
            try hapticAdvancedPlayer?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic")
        }
    }
    
    private func makePattern(
        duration: [Double],
        powers: [Float]
    ) throws -> CHHapticPattern {
        var events: [CHHapticEvent] = []
        var relativeTime = 0.0
        
        duration.enumerated().forEach {
            let duration = $0.element
            let power = powers[$0.offset]
            
            let intensity = CHHapticEventParameter(
                parameterID: .hapticIntensity,
                value: power
            )
            let sharpness = CHHapticEventParameter(
                parameterID: .hapticSharpness,
                value: 0.6
            )
            
            let params = [intensity, sharpness]
            
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: params,
                relativeTime: 1,
                duration: duration
            )
            
            relativeTime += duration
            events.append(event)
        }
        
        return try CHHapticPattern(
            events: events,
            parameters: []
        )
    }
    
    func playHaptic(
        duration: [Double],
        powers: [Float]
    ) {
        do {
            try hapticAdvancedPlayer?.stop(atTime: 0)
            
            let pattern = try makePattern(
                duration: duration,
                powers: powers
            )
            
            try hapticEngine?.start()
            hapticAdvancedPlayer = try hapticEngine?.makeAdvancedPlayer(with: pattern)
            hapticAdvancedPlayer?.loopEnabled = true
            hapticAdvancedPlayer?.playbackRate = 1.0
            
            
            try hapticAdvancedPlayer?.start(atTime: 0)
            
        } catch {
            print("Cannot play haptic")
        }
    }
    
    private func generateHapticPattern(_ style: HapticStyle) -> CHHapticPattern? {
        switch style {
        // rigid twice
        case .rigidTwice:
            let intensity = CHHapticEventParameter(
                parameterID: .hapticIntensity,
                value: 2
            )
            let sharpness = CHHapticEventParameter(
                parameterID: .hapticSharpness,
                value: 1
            )
            
            let firstEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
                relativeTime: 0
            )
            let secondEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
                relativeTime: 0.1
            )
            
            let pattern = try? CHHapticPattern(
                events: [firstEvent, secondEvent],
                parameters: []
            )
            return pattern
            
        // success
        case .success:
            let firstIntensity = CHHapticEventParameter(
                parameterID: .hapticIntensity,
                value: 1
            )
            let firstSharpness = CHHapticEventParameter(
                parameterID: .hapticSharpness,
                value: 0.4
            )
            let firstEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [firstIntensity, firstSharpness],
                relativeTime: 0
            )
            
            let secondIntensity = CHHapticEventParameter(
                parameterID: .hapticIntensity,
                value: 2
            )
            let secondSharpness = CHHapticEventParameter(
                parameterID: .hapticSharpness,
                value: 0.8
            )
            let secondEvent = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [secondIntensity, secondSharpness],
                relativeTime: 0.15
            )
            
            let pattern = try? CHHapticPattern(
                events: [firstEvent, secondEvent],
                parameters: []
            )
            return pattern
            
        case let .light(times: times):
            let intensity = CHHapticEventParameter(
                parameterID: .hapticIntensity,
                value: 0.5
            )
            let sharpness = CHHapticEventParameter(
                parameterID: .hapticSharpness,
                value: 0.3
            )
            
            var events: [CHHapticEvent] = [CHHapticEvent]()
            
            for i in 0 ..< times {
                let event = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [intensity, sharpness],
                    relativeTime: Double(i) * 0.1
                )
                events.append(event)
            }
            
            let pattern = try? CHHapticPattern(
                events: events,
                parameters: []
            )
            return pattern
        }
    }
}
