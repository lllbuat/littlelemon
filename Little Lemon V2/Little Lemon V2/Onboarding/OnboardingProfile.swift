//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct OnboardingProfile: View {
    let persistence = PersistenceController.shared
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
    
    @State private var firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
    @State private var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
    
    var body: some View {
        
        NavigationStack{
            VStack {
                NavBarView(showBackBtn: false, showProfileBtn: false)
                
                HeroSectionView()
                    .frame(height: 300)
                
                VStack {
                    Text("Register")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textCase(.uppercase)
                        .font(Font(Fonts.SectionTitle))
                    
                    ScrollView(.vertical) {
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
               Menu().environment(\.managedObjectContext, persistence.container.viewContext)
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
