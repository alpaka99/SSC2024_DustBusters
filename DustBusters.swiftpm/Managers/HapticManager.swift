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
    
    enum HapticStyle {
        case rigidTwice
        case success
        case light(times: Int)
        
        case nearDeath
        case superUnhealthy
        case unHealthy
        case normal
        case semiHealthy
        case healthy
        case superHealthy
    }
    
    func stopHaptic() {
        do {
            try hapticAdvancedPlayer?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic")
        }
    }
    
    func createHaptic(_ hapticStyle: HapticStyle, _ loop: Bool) {
        do {
            try hapticAdvancedPlayer?.stop(atTime: 0)
            
            guard let pattern = generateHapticPattern(hapticStyle) else { return }
            
            try hapticEngine?.start()
            hapticAdvancedPlayer = try hapticEngine?.makeAdvancedPlayer(with: pattern)
            hapticAdvancedPlayer?.loopEnabled = loop
            hapticAdvancedPlayer?.playbackRate = 0.4
            
            
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
            
        case .nearDeath:
            let firstEvent = createEvent(0.3, 0.7, 0.5)
            let secondEvent = createEvent(0.3, 0.7, 0.7)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events: [CHHapticEvent] = [firstEvent, secondEvent, endEvent]
            
            
            return createHapticPattern(events)
            
        case .superUnhealthy:
            let firstEvent = createEvent(0.4, 0.6, 0.4)
            let secondEvent = createEvent(0.4, 0.6, 0.5)
            let thirdEvent = createEvent(0.3, 0.7, 0.7)
            let fourthEvent = createEvent(0.3, 0.7, 0.8)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events: [CHHapticEvent] = [firstEvent, secondEvent, thirdEvent, fourthEvent, endEvent]
            
            return createHapticPattern(events)
            
        case .unHealthy:
            let firstEvent = createEvent(0.6, 0.4, 0.6)
            let secondEvent = createEvent(0.6, 0.4, 0.65)
            let thirdEvent = createEvent(0.5, 0.5, 0.7)
            let fourthEvent = createEvent(0.5, 0.5, 0.75)
            let endEvent = createEvent(0, 0, 1.2)
            
            return createHapticPattern([firstEvent, secondEvent, thirdEvent, fourthEvent, endEvent])
            
        case .normal:
            let firstEvent = createEvent(0.6, 0.4, 0.5)
            let secondEvent = createEvent(0.6, 0.4, 0.7)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events = [firstEvent, secondEvent, endEvent]

            return createHapticPattern(events)
            
        case .semiHealthy:
            let firstEvent = createEvent(0.2, 0.6, 0.35)
            let secondEvent = createEvent(0.8, 0.3, 0.4)
            let thirdEvent = createEvent(0.5, 0.4, 0.5)
            let fourthEvent = createEvent(0.3, 0.6, 0.6)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events = [firstEvent, secondEvent, thirdEvent, fourthEvent, endEvent]
            
            return createHapticPattern(events)
            
        case .healthy:
            let firstEvent = createEvent(0.3, 0.6, 0.4)
            let secondEvent = createEvent(0.8, 0.3, 0.5)
            let thirdEvent = createEvent(0.8, 0.6, 0.6)
            let fourthEvent = createEvent(0.3, 0.6, 0.7)
            
            let fifthEvent = createEvent(0.8, 0.3, 0.8)
            let sixthEvent = createEvent(0.3, 0.6, 0.9)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events = [firstEvent, secondEvent, thirdEvent, fourthEvent, fifthEvent, sixthEvent, endEvent]
            
            return createHapticPattern(events)
            
        case .superHealthy:
            let firstEvent = createEvent(0.8, 0.3, 0.5)
            let secondEvent = createEvent(0.6, 0.5, 0.6)
            let thirdEvent = createEvent(1, 0.2, 0.7)
            let fourthEvent = createEvent(0.9, 0.3, 0.8)
            let endEvent = createEvent(0, 0, 1.2)
            
            let events = [firstEvent, secondEvent, thirdEvent, fourthEvent, endEvent]
            
            return createHapticPattern(events)
        }
    }
    
    
    private func createIntensity(_ intensity: Float) -> CHHapticEventParameter {
        let hapticIntensity: CHHapticEventParameter = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: intensity
        )
        
        return hapticIntensity
    }
    
    private func createSharpness(_ sharpness: Float) -> CHHapticEventParameter {
        let hapticSharpness: CHHapticEventParameter = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: sharpness
        )
        
        return hapticSharpness
    }
    
    private func createEvent(
        _ intensity: Float,
        _ sharpness: Float,
        _ relativeTime: TimeInterval
    ) -> CHHapticEvent {
        let intensity = createIntensity(intensity)
        let sharpness = createSharpness(sharpness)
        
        let hapticEvent: CHHapticEvent = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: relativeTime
        )
        
        return hapticEvent
    }
    
    private func createHapticPattern(_ events: [CHHapticEvent]) -> CHHapticPattern? {
        let pattern = try? CHHapticPattern(
            events: events,
            parameters: []
        )
        
        return pattern
    }
}
