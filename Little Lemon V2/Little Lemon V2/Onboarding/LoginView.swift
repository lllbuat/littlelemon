//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        VStack {
            HeroSectionView()
                .frame(height: 300)
            
            VStack(spacing: 15) {
                Button("Log in") {
                    
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: .infinity)
                .font(Font(Fonts.LeadText))
                .foregroundColor(Colors.DarkGray)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGreen, style: StrokeStyle(lineWidth: 0.5)))
                
                Button("Sign up") {
                    
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .frame(maxWidth: .infinity)
                .font(Font(Fonts.LeadText))
                .foregroundColor(Colors.DarkGray)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGreen, style: StrokeStyle(lineWidth: 0.5)))
            }
            .frame(height: 300)
            .padding([.leading, .trailing], 50)
            .padding([.top, .bottom], 5)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
