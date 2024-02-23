//
//  File.swift
//  
//
//  Created by user on 2/23/24.
//

import Foundation

extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
