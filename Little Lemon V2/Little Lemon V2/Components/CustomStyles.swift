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

struct YellowButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(Fonts.LeadText))
            .padding(10)
            .foregroundColor(Colors.DarkGray)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Colors.Yellow)
                .opacity(configuration.isPressed ? 0.5 : 1))
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? Colors.DarkGreen : .gray)
                .font(Font(Fonts.HighlightText))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}

