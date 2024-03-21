//
//  HeroSection.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct HeroSectionView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Little Lemon")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font(Fonts.DisplayTitle))
                    .foregroundStyle(Colors.Yellow)
                //                        .background(Color.gray)
                
                Text("Chicago")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font(Fonts.Subtitle))
                    .foregroundStyle(.white)
                //                        .background(Color.colorLightGray)
                    .offset(y: -20)
            }
            
            HStack {
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .font(Font(Fonts.HighlightText))
                    .foregroundStyle(.white)
                
                Image("hero-image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150, alignment: .center)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            //                .background(Color.green)
            .offset(y: -20)
            
        } //  hero section
        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
        .background(Colors.DarkGreen)
    }
}

#Preview {
    HeroSectionView()
}
