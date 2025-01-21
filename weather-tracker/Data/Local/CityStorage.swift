//
//  CitySavedStorage.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation
class CityStorage {
    private let key = "SavedCity"

    func saveCity(_ cityName: String) {
        UserDefaults.standard.set(cityName, forKey: key)
    }

    func loadCity() -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}



class MockCityStorage: CityStorage {
    private var savedCity: String?

    override func loadCity() -> String? {
        return savedCity
    }

    override func saveCity(_ city: String) {
        savedCity = city
    }
}
