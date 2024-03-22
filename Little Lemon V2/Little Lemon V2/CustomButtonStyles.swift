//
//  CustomButtonStyles.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 22/3/2024.
//

import Foundation
import SwiftUI

struct LightButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(Fonts.LeadText))
            .padding(10)
            .foregroundColor(configuration.isPressed ? Colors.LightGray : Colors.DarkGray)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .strokeBorder(Colors.DarkGreen, lineWidth: 0.5))
    }
}
    
struct DarkButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(Fonts.LeadText))
            .padding(10)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Colors.DarkGreen)
                .opacity(configuration.isPressed ? 0.5 : 1))
    }
}

