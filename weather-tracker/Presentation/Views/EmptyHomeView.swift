//
//  EmptyHomeView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore

struct EmptyHomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("No City Selected")
                .font(.title2)
            Text("Please Search For A City")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}
