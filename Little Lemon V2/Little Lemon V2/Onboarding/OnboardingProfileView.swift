//
//  LoginView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 21/3/2024.
//

import SwiftUI

struct OnboardingProfileView: View {
    // for navigation
    static let tag = ViewTags.OnboardingProfileView
    @State var path: NavigationPath = .init()
    
    // for member profile
    @StateObject var memberProfile = MemberProfileModel()
        
    // for alert box
    @State private var showAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavBarView(path: $path, memberProfile: memberProfile, showBackBtn: false, showProfileBtn: false)
                
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
                            
                            NamedTextField(text: $memberProfile.firstName, title: "First Name")
                                .autocorrectionDisabled()
                            NamedTextField(text:  $memberProfile.lastName, title: "Last Name")
                                .autocorrectionDisabled()
                            NamedTextField(text:  $memberProfile.email, title: "Email")
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                            NamedTextField(text:  $memberProfile.phoneNumber, title: "Phone Number")
                        }
                        
                    }
                    
                    Button {
                        let (isValid, errorMsg) = memberProfile.validateText()
                        
                        if !isValid {
                            // show error message
                            self.alertMsg = errorMsg
                            self.showAlert = true
                        } else {
                            // save to profile
                            self.memberProfile.saveProfile()
                            
                            // go to next page
                            path.append(OnboardingPreferencesView.tag)
                        }
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                    
                }
                .alert(alertMsg, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                .padding(10)
                .navigationBarHidden(true)
            }
            .navigationDestination(for: String.self) { tag in
                if tag == ViewTags.MenuView {
                    MenuView(path: $path, memberProfile: memberProfile)
                } else if tag == ViewTags.OnboardingProfileView {
                    OnboardingProfileView()
                } else if tag == ViewTags.OnboardingPreferencesView {
                    OnboardingPreferencesView(path: $path, memberProfile: memberProfile)
                } else if tag == ViewTags.OnboardingReviewView {
                    OnboardingReviewView(path: $path, memberProfile: memberProfile)
                } else if tag == ViewTags.UserProfileView {
                    UserProfileView(path: $path, memberProfile: memberProfile)
                }
            }
            
            .onAppear {
                // if logged in, move to menu
                if self.memberProfile.isLoggedIn {
                    path.append(MenuView.tag)
                }
            }
        }
    }
}

//#Preview {
//    OnboardingProfile()
//}
