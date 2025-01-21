//
//  WeatherDetailView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct WeatherDetailView: View {
    
    let weatherInfo : WeatherInfo
//    @State private var weatherInfo: WeatherInfo?
//    @State private var isLoading: Bool = false
//    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
                
          
                
                if let iconURL = weatherInfo.conditionIconURL {
                    AsyncImage(url: iconURL) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                                .frame(width: 100, height: 100)
                            case .success(let image):
                                image.resizable()
                                .scaledToFit()
                                .frame(width: 123, height: 123)
                            case .failure:
                                Image(systemName: "cloud.sun.fill")
                                .font(.largeTitle)
                            @unknown default:
                                EmptyView()
                                }
                            }
                        }

                     HStack {
                            Text(weatherInfo.cityName)
                             .font(.poppinsTitle)
                            Image(systemName: "location.fill")
                             .foregroundColor(.brandBackground)
                            }

                        Text("\(Int(weatherInfo.temperature))°")
                            .font(.poppinsHeader)
                        

                   
                    HStack(spacing: 16) {
                        DetailCardView(label: "Humidity", value: "\(weatherInfo.humidity)%")
                        DetailCardView(label: "UV", value: "\(Int(weatherInfo.uvIndex))")
                        DetailCardView(label: "Feels Like", value: "\(Int(weatherInfo.feelsLike))°")
                    }
                            .padding()
                            .background(content: { Color.brandLightForeground.cornerRadius(16) })
                            Spacer()
                }
                .padding()
    }
    
  
}

#Preview {
    WeatherDetailView(weatherInfo: demoWeathereInfo)
}


