//
//  Reducer.swift
//  DustBusters
//
//  Created by user on 2/11/24.
//

import Foundation

protocol Reducer<States, Actions>: AnyObject, ObservableObject, Hashable {
    associatedtype States
    associatedtype Actions: ReducerAction
    
    var reducerId: String { get }
    
    func send(_ action: Actions)
    
    func reduce(states: inout States, action: Actions)
}

extension Reducer {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.reducerId == rhs.reducerId
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
}

protocol ReducerAction { }


final class SampleReducer: Reducer {
    struct States {
        
    }
    
    enum Actions: ReducerAction {
        case buttonPressed(Int), titlePressed
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
