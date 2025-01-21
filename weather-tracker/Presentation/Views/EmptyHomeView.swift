//
//  EmptyHomeView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct EmptyHomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("No City Selected")
                .font(.poppinsTitle)
                .lineSpacing(15)
                .foregroundColor(Color.brandForeground)
            Text("Please Search For A City")
                .font(.poppinsBody)
                .foregroundColor(Color.brandForeground)
                .lineSpacing(6)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    EmptyHomeView()
}

