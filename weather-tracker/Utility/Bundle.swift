//
//  Bundle.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation

extension Bundle {
    var apiKey: String {
        infoDictionary?["API_KEY"] as? String ?? ""
    }
}


