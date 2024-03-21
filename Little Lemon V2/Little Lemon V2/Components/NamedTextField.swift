//
//  NamedTextField.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct NamedTextField: View {
    @Binding var text: String
    var title: String = "TextField Title"
    
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            TextField(text, text: $text)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.Gray, style: StrokeStyle(lineWidth: 0.5)))
        }
    }
}

#Preview {
    NamedTextField(text: .constant("hello"), title: "First Name")
}
