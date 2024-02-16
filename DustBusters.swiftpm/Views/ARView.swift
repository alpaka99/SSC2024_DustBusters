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
    @State private var isShowingModal: Bool = false
    
    var body: some View {
        arViewControllerContainer
            .onDisappear {
                self.arViewControllerContainer = nil
            }
    }
}


