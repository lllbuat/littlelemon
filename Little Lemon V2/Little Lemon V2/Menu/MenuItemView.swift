//
//  MenuItemView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 15/3/2024.
//

import SwiftUI

struct MenuItemView: View {
    
    
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Greek Salad")
                    .font(Font(Fonts.CardTitle))
                    .foregroundStyle(Colors.DarkGray)
                    .padding([.top, .bottom], 7)
                
                Text("The famous greek salad of crispy lettuce, peppers, olives, our Chicago.")
                    .font(Font(Fonts.ParagraphText))
                    .foregroundStyle(Colors.DarkGreen)
                
                Text("$12.99")
                    .font(Font(Fonts.HighlightText))
                    .foregroundStyle(Colors.DarkGreen)
            }
            
            Spacer()
            
            AsyncImage(url: URL(string: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .aspectRatio(contentMode: .fit)
        }
//        .contentShape(Rectangle())
    }
}

#Preview {
    MenuItemView()
}
