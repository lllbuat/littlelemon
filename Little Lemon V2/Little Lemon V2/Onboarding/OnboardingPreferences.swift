//
//  OnboardingPreferences.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 22/3/2024.
//

import SwiftUI

struct OnboardingPreferences: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var emailOptionOrderStatus = true
    @State private var emailOptionPasswordChanges = true
    @State private var emailOptionSpecialOffer = true
    @State private var emailOptionNewsletter = true
    
    var body: some View {
        NavigationStack{
            VStack {
                HeroSectionView()
                    .frame(height: 300)
                                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            Text("Email Notifications")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font(Fonts.CardTitle))
                                .foregroundStyle(Colors.DarkGray)
                            
                            Group {
                                Toggle("Order status", isOn: $emailOptionOrderStatus)
                                Toggle("Password changes", isOn: $emailOptionPasswordChanges)
                                Toggle("Special offers", isOn: $emailOptionSpecialOffer)
                                Toggle("Newsletter", isOn: $emailOptionNewsletter)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .toggleStyle(CheckboxStyle())
                            .font(Font(Fonts.ParagraphText))
                        }
                    }
                    Spacer()
                    
                    HStack {
                        Button {
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Text("Back")
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(LightButton())
                        
                        NavigationLink(destination: OnboardingReview()) {
                            Text("Review")
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(DarkButton())
                    }
                }
                .padding(10)
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    OnboardingPreferences()
}
