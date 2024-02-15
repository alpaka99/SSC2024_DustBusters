//
//  File.swift
//  
//
//  Created by user on 2/14/24.
//

import Foundation

final class ARViewReducer: Reducer {
    struct States {
        
    }
    
    enum Action: ReducerAction {
        
    }
    
    @Published var states: States = States()
    private(set) var reducerId: String
    
    init(reducerId: String) {
        self.reducerId = reducerId
    }
    
    
    func send(_ action: Actions) {
        self.reduce(states: &states, action: action)
    }
    
    func reduce(states: inout States, action: Actions) {
        switch action {
        case .buttonPressed(let x):
            print(x)
            break
        case .titlePressed:
            print("title pressed")
            break
        }
    }
    
}
