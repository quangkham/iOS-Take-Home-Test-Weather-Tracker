//
//  WeatherDetailView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct WeatherDetailView: View {
    let weatherInfo: WeatherInfo

    var body: some View {
        VStack(spacing: 20) {
            Text(weatherInfo.cityName)
                .font(.title)
                .padding(.top)

            // Display weather condition icon
            // You could load the icon from the URL with an AsyncImage in iOS 15+
            if let iconURL = weatherInfo.conditionIconURL {
                AsyncImage(url: iconURL) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
            }

            Text("\(Int(weatherInfo.temperature))°")
                .font(.system(size: 50, weight: .bold))

            Text(weatherInfo.conditionText)
                .font(.headline)

            // Additional details
            HStack(spacing: 40) {
                VStack {
                    Text("Humidity")
                    Text("\(weatherInfo.humidity)%")
                }
                VStack {
                    Text("UV Index")
                    Text("\(Int(weatherInfo.uvIndex))")
                }
                VStack {
                    Text("Feels like")
                    Text("\(Int(weatherInfo.feelsLike))°")
                }
            }
            .padding()

            Spacer()
        }
    }
}
