//
//  CitySearchItem.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//


struct CitySearchItem: Codable {
    let id: Int?
    let name: String
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let url: String?
}
