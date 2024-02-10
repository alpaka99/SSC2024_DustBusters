//
//  MainViewReducer.swift
//  DustBusters
//
//  Created by user on 2/10/24.
//

import Foundation

final class MainViewReducer: ObservableObject {
    internal let reducerId: String = "MAIN"
    
    static func == (lhs: MainViewReducer, rhs: MainViewReducer) -> Bool {
        return lhs.reducerId == rhs.reducerId
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    let appTitle: String = "Dust Busters!"
    let startButtonTitle: String = "Start"
    let continueButtonTitle: String = "Continue"
    
    @Published var isStartDisabled: Bool = false
    @Published var isContinueDisabled: Bool = true
}
