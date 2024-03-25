//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct OnboardingProfile: View {
    @State private var isLoggedIn = false
    
    @State private var firstName = "Alice"
    @State private var lastName = "Bob"
    @State private var email = "hello@world.com"
    @State private var phoneNumber = "123-456-7890"
    
    var body: some View {
        
        NavigationStack{
            VStack {
                HeroSectionView()
                    .frame(height: 300)
                
                VStack {
                    Text("Register")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textCase(.uppercase)
                        .font(Font(Fonts.SectionTitle))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            Text("Profile")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font(Fonts.CardTitle))
                                .foregroundStyle(Colors.DarkGray)
                            
                            NamedTextField(text: $firstName, title: "First Name")
                            NamedTextField(text: $lastName, title: "Last Name")
                            NamedTextField(text: $email, title: "Email")
                            NamedTextField(text: $phoneNumber, title: "Phone Number")
                        }
                        
                    }
                    NavigationLink(destination: OnboardingPreferences()) {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                }
//                .background(Color.gray)
                .padding(10)
                .navigationBarHidden(true)


                
            }
            .navigationDestination(isPresented: $isLoggedIn) {
               Home()
            }
            .onAppear {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
            }
        }
    }
}

#Preview {
    OnboardingProfile()
}
