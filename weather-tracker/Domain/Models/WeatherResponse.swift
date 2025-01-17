//
//  WeatherResponse.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

struct WeatherResponse: Decodable {
    let location: Location
    let current: Current
    
    struct Location: Decodable {
        let name: String
    }
    
    struct Current: Decodable {
        let tempC: Double
        let feelslikeC: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case feelslikeC = "feelslike_c"
            case condition
            case humidity
            case uv
        }
    }
    
    struct Condition: Decodable {
        let text: String
        let icon: String
    }
}
