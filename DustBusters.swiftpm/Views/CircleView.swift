//
//  File.swift
//  
//
//  Created by user on 2/18/24.
//

import Foundation
import SwiftUI

struct CircleView: View {
    let objectName: String
    let diameter: CGFloat
    let objectColor: Color
    
    
    var body: some View {
        Circle()
            .fill(objectColor)
            .frame(width: diameter)
    }
}


extension CircleView: Hashable {
    
}

//#Preview {
//    CircleView(objectName: "Test", diameter: 2, objectColor: .red)
//}
