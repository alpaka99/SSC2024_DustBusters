//
//  File.swift
//  
//
//  Created by user on 2/25/24.
//

import Foundation
import SwiftUI

extension Shape {
    @inlinable func animatedPathDraw(
        from: CGFloat = 0,
        to: CGFloat = 1,
        lineWidth: CGFloat = 1
    ) -> some Shape {
        self
            .trim(from: from, to: to)
            .stroke(style: StrokeStyle(lineWidth: lineWidth))
    }
}
