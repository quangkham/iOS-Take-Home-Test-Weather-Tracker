//
//  WeatherServiceError.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

enum WeatherServiceError: Error {
    case emptyAPIKey
    case invalidURL
    case invalidResponseCode(Int)
    case decodingFailure
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .emptyAPIKey:
            return "API key is empty. Please check your configuration."
        case .invalidURL:
            return "The URL is invalid. Please try again."
        case .invalidResponseCode(let code):
            return "Server returned response code \(code)."
        case .decodingFailure:
            return "Unable to parse weather data. Try again later."
        case .unknown(let underlying):
            return "Network error: \(underlying.localizedDescription)"
        }
    }
}
