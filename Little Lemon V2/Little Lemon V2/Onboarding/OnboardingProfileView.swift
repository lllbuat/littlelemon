//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct OnboardingProfileView: View {
    static let tag = ViewTags.OnboardingProfileView
    @State var path: NavigationPath = .init()
    
    @State private var showAlert = false
//    @State private var goToPreference = false
    @State private var isLoggedIn = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State var clearFields = false
    
    var body: some View {
//        let _ = print("OnboardingProfile")
        NavigationStack(path: $path) {
            VStack {
                NavBarView(path: $path, showBackBtn: false, showProfileBtn: false)
                
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
                                .textInputAutocapitalization(.never)
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
                            
                            path.append(OnboardingPreferencesView.tag)
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
            .navigationDestination(for: String.self) { tag in
                if tag == ViewTags.MenuView {
                    MenuView(path: $path)
                } else if tag == ViewTags.OnboardingProfileView {
                    OnboardingProfileView()
                } else if tag == ViewTags.OnboardingPreferencesView {
                    OnboardingPreferencesView(path: $path)
                } else if tag == ViewTags.OnboardingReviewView {
                    OnboardingReviewView(path: $path)
                } else if tag == ViewTags.UserProfileView {
                    UserProfileView(path: $path)
                } else {
                    SampleView(path: $path)
                }
            }
            
            .onAppear {
                self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
                if self.isLoggedIn {
                    path.append(MenuView.tag)
                } else if self.clearFields {
                    // reset all fields
                    firstName = ""
                    lastName = ""
                    email = ""
                    phoneNumber = ""
                    
                    self.clearFields = false
                }
            }
        }
        .alert("Empty First Name/Last Name/Email/Phone Number",
               isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

//#Preview {
//    OnboardingProfile()
//}
