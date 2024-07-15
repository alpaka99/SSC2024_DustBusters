//
//  SwiftUIView.swift
//  
//
//  Created by user on 2/25/24.
//

import SwiftUI

struct TestView: View {
    enum HeartBeatType: String {
        case nearDeath, superUnhealthy, unHealthy, normal, semiHealthy, healthy, superHealthy
    }
    
    var body: some View {
        VStack {
            Button {
                HapticManager.shared?.createHaptic(.nearDeath, true)
            } label: {
                Text("nearDeath")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.superUnhealthy, true)
            } label: {
                Text("superunhealthy")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.unHealthy, true)
            } label: {
                Text("unhealthy")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.normal, true)
            } label: {
                Text("normal")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.semiHealthy, true)
            } label: {
                Text("semihealthy")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.healthy, true)
            } label: {
                Text("healthy")
            }
            .padding(40)
            
            Button {
                HapticManager.shared?.createHaptic(.superHealthy, true)
            } label: {
                Text("superhealthy")
            }
            .padding(40)
        }
    }
}

struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
