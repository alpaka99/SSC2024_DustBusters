//
//  File.swift
//  
//
//  Created by user on 2/14/24.
//

import Foundation
import SwiftUI
import UIKit

struct ARView: View {
    let arviewReducer: any Reducer
    @State private var arViewControllerContainer: ARViewControllerContainer? = ARViewControllerContainer()
    let arViewFinishedPublisher = NotificationCenter.default.publisher(for: Notification.Name("ARViewEndNotification"))
    @State private var viewToShow: ViewToShow = .arView
    enum ViewToShow {
        case arView, tutorial
    }
    
    var body: some View {
        switch viewToShow {
        case .arView:
            arViewControllerContainer
                .onDisappear {
                    self.arViewControllerContainer = nil
                }
                .onReceive(arViewFinishedPublisher) { _ in
                    // MARK: endARView
                    self.arViewControllerContainer = nil
                    viewToShow = .tutorial
                }
        case .tutorial:
            ModalView(modalText: ["To NextView", "Lets go"])
        }
    }
    
    
    var tutorialView: some View {
        VStack {
            EmptyView()
        }
    }
}


