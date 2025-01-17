//
//  CitySavedStorage.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation
struct CityStorage {
    private let key = "SavedCity"

    func saveCity(_ cityName: String) {
        UserDefaults.standard.set(cityName, forKey: key)
    }

    func loadCity() -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
