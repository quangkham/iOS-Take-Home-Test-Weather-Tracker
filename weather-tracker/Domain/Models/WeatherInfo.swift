//
//  WeatherInfo.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation
struct WeatherInfo {
    let cityName: String
    let temperature: Double
    let conditionText: String
    let conditionIconURL: URL?
    let humidity: Int
    let uvIndex: Double
    let feelsLike: Double
    let windSpeed: Double?
    let windDirection: String?
    let pressure: Double?
    let lastUpdated: String?
    
}

let demoWeathereInfo: WeatherInfo = .init(
    cityName: "Hanoi",
    temperature: 20.0,
    conditionText: "Sunny",
    conditionIconURL: nil,
    humidity: 60,
    uvIndex: 8.0,
    feelsLike: 22.0,
    windSpeed: 10.0,
    windDirection: "NE",
    pressure: 0.0, lastUpdated: ""
)

