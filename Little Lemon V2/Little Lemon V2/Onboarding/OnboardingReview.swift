//
//  OnboardingReview.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct OnboardingReview: View {
    let persistence = PersistenceController.shared
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstName = "Alice"
    @State private var lastName = "Bob"
    @State private var email = "hello@world.com"
    @State private var phoneNumber = "123-456-7890"
    
    @State private var emailOptionOrderStatus = true
    @State private var emailOptionPasswordChanges = false
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
                            Text("Profile")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font(Fonts.CardTitle))
                                .foregroundStyle(Colors.DarkGray)
                            
                            NamedText(text: firstName, title: "First Name")
                            NamedText(text: lastName, title: "Last Name")
                            NamedText(text: email, title: "Email")
                            NamedText(text: phoneNumber, title: "Phone Number")
                            
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
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            
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
                        
                        NavigationLink(destination: Menu()
                            .environment(\.managedObjectContext, persistence.container.viewContext)) {
                            Text("Register")
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
    OnboardingReview()
}
