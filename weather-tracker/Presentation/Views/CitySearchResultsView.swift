//
//  CitySearchResultsView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct CitySearchResultsView: View {
    @ObservedObject var viewModel: WeatherViewModel
   // @Binding var isShowingSearchResults: Bool
    var onCitySelected: (String) -> Void //closure

    var body: some View {
        
        VStack {
            if viewModel.searchResults.isEmpty {
                Text("No Result found")
                    .font(.poppinsCaption)
                    .foregroundColor(.brandForeground)
            }
            else {
                List(viewModel.searchResults, id: \.name) { item in
                    Button {
                        
                        onCitySelected(item.name)
 
                    } label: {
                        CityCardView(cityName: item.name, temperature: viewModel.getTemperature(for: "\(item.lat)"))
                    }
                    .listRowBackground(Color.clear)
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
            }
        }
        
    }
}
