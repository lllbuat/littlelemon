//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct OnboardingProfile: View {
//    let persistence = PersistenceController.shared
    
    @State private var showAlert = false
    @State private var goToPreference = false
    
    @State private var isLoggedIn = false
//    UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    var body: some View {
        let _ = print("OnboardingProfile")
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

                    
                    Button {
                        if (firstName.isEmpty) || (lastName.isEmpty) || (email.isEmpty) || (phoneNumber.isEmpty) {
                            self.showAlert = true
                        } else {
                            UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.kFirstName)
                            UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.kLastName)
                            UserDefaults.standard.set(email, forKey: UserDefaultsKeys.kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: UserDefaultsKeys.kPhoneNumebr)
                            self.goToPreference = true
                        }
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                    
                }
//                .background(Color.gray)
                .padding(10)
                .navigationBarHidden(true)
            }
            .navigationDestination(isPresented: $isLoggedIn) {
               Menu()
//                    .environment(\.managedObjectContext, persistence.container.viewContext)
            }
            .navigationDestination(isPresented: $goToPreference) {
               OnboardingPreferences()
            }
            .onAppear {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
//                print(self.isLoggedIn)
//                self.isLoggedIn = false
//                UserDefaults.standard.set(isLoggedIn, forKey: UserDefaultsKeys.kIsLoggedIn)
            }
        }
        .alert("Empty First Name/Last Name/Email/Phone Number",
               isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    OnboardingProfile()
}
