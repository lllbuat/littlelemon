//
//  NamedText.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct NamedText: View {
    var text: String = "content"
    var title: String = "TextField Title"
    
    var body: some View {
        HStack (alignment: .bottom) {
            Text(title + ": ")
//                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
//                .padding(.vertical, 5)
        }
    }
}

#Preview {
    NamedText(text: "Alice", title: "First Name")
}
