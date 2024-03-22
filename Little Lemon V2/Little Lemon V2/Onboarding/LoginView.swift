//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoggedIn = false
//    @State private var goToP2 = false
    
    @State private var firstName = "Alice"
    @State private var lastName = "Bob"
    @State private var email = "hello@world.com"
    @State private var phoneNumber = "123-456-7890"
    
    var body: some View {
        
        NavigationStack{
            VStack {
                HeroSectionView()
                    .frame(height: 300)
                
                VStack(spacing: 15) {
                    
                    Text("Register!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textCase(.uppercase)
                        .font(Font(Fonts.SectionTitle))
                    
                    NamedTextField(text: $firstName, title: "First Name")
                    NamedTextField(text: $lastName, title: "Last Name")
                    NamedTextField(text: $email, title: "Email")
                    NamedTextField(text: $phoneNumber, title: "Phone Number")

                    Spacer()
                    
                    Button {
                        self.isLoggedIn = true
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                
                
            }
            .navigationDestination(isPresented: $isLoggedIn) {
               OnboardingPreferences()
            }
            .onAppear {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
//                self.firstName = ""
//                self.lastName = ""
//                self.email = ""
            }
        }
    }
}

#Preview {
    LoginView()
}
