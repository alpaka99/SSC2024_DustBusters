//
//  File.swift
//  
//
//  Created by user on 2/23/24.
//

import Foundation
import SwiftUI

extension View {
    func changeOrientation(to orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}
