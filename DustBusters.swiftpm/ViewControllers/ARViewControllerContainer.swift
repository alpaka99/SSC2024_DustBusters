//
//  File.swift
//  
//
//  Created by user on 2/14/24.
//

import Foundation
import SwiftUI

struct ARViewControllerContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = ARViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> ARViewControllerContainer.Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject {
        
    }
}
