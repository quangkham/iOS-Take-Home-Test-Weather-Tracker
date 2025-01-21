//
//  CityCardView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct CityCardView: View {
    let cityName: String
    let temperature: Double
    
    var body: some View {
        HStack {

            VStack(alignment: .leading, spacing: 4) {
                Text(cityName)
                    .font(.poppinsHeadline)
                    .foregroundColor(.brandBackground)
            }
            Spacer()
            Image("Cloudy")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.clear)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.brandLightForeground.cornerRadius(12))
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    CityCardView(cityName: "Baghdad", temperature: 0.0)
}
