//
//  File.swift
//  
//
//  Created by user on 2/24/24.
//

import Foundation
import SwiftUI

extension Color {
    func fromHex(_ hexCode: String, _ alpha: CGFloat = 1.0) -> Self {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let hexUIColor = UIColor.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
        
        return Color(uiColor: hexUIColor)
    }
}
