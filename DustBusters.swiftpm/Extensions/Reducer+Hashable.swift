//
//  File.swift
//  
//
//  Created by user on 2/23/24.
//

import Foundation

extension Reducer {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.reducerId == rhs.reducerId
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
}
