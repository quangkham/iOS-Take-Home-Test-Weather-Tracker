//
//  Font.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

extension Font {
    // MARK: - Poppins Base
    
    private static func poppinsFont(_ size: CGFloat, weight: PoppinsWeight) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    static var poppinsHeader: Font {
        poppinsFont(70, weight: .medium)
    }

    
    static var poppinsHeader2: Font {
        poppinsFont(60, weight: .medium)
    }
 
    static var poppinsTitle: Font {
        poppinsFont(30, weight: .semiBold)
    }

    
    static var poppinsHeadline: Font {
        poppinsFont(20, weight: .medium)
    }

    
    static var poppinsBody: Font {
        poppinsFont(15, weight: .regular)
    }

   
    static var poppinsCaption: Font {
        poppinsFont(12, weight: .regular)
    }
}


enum PoppinsWeight: String {
    case thin      = "Poppins-Thin"
    case light     = "Poppins-Light"
    case regular   = "Poppins-Regular"
    case medium    = "Poppins-Medium"
    case semiBold  = "Poppins-SemiBold"
    case bold      = "Poppins-Bold"
    
}
