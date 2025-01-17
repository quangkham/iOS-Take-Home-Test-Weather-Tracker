//
//  Color.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

extension Color {
   
    init(hex: String) {
     
        let sanitizedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var rgb: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&rgb)
        
       
        let length = sanitizedHex.count
        let r, g, b, a: UInt64
        switch length {
        case 6: 
            (r, g, b, a) = (rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF, 0xFF)
        case 8:
            (a, r, g, b) = (rgb >> 24 & 0xFF, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
        default:
            (r, g, b, a) = (1, 1, 1, 1) 
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Custom App Colors

extension Color {
    
    static let brandBackground = Color(hex: "#2C2C2C")
    static let brandForeground = Color(hex: "#9A9A9A")
    static let brandLightForeground = Color(hex: "#F2F2F2")

  
}
