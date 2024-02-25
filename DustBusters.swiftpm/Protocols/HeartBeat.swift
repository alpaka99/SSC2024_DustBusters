//
//  File.swift
//  
//
//  Created by user on 2/25/24.
//

import Foundation
import SwiftUI

protocol HeartBeat {
    var drawingErasing: Bool { get set }
    var startPosition: CGPoint { get }
}

typealias HeartBeatView = HeartBeat & View

