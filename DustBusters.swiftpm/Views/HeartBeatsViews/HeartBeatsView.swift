//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct HeartBeatsView: View {
    @Binding var counter: Int
    @State private var drawingErasing: Bool = false
    
    let startPosition: CGPoint
    private let heartBeatTypes: [HeartBeatType] = HeartBeatType.allCases
    
    private var index: Int {
        return counter % heartBeatTypes.count
    }
    
    private var heartBeatType: HeartBeatType {
        return heartBeatTypes[index]
    }
    
    private enum HeartBeatType: Int, CaseIterable {
        case nearDeath = 0, superUnHealthy, unHealthy, normal, semiHealthy, healthy, superHealthy
    }
    
    var body: some View {
        VStack {
            switch heartBeatType {
            case .nearDeath:
                NearDeathHeartBeatView(startPosition: startPosition)
            case .superUnHealthy:
                SuperUnHealthyHeartBeatView(startPosition: startPosition)
            case .unHealthy:
                UnHealthyHeartBeatView(startPosition: startPosition)
            case .normal:
                NormalHeartBeatView(startPosition: startPosition)
            case .semiHealthy:
                SemiHealthyHeartBeatView(startPosition: startPosition)
            case .healthy:
                HealthyHeartBeatView(startPosition: startPosition)
            case .superHealthy:
                SuperHealthyHeartBeatView(startPosition: startPosition)
            }
        }
    }
}

