//
//  OnboardingView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 5/4/2024.
//

import SwiftUI

struct OnboardingView: View {
    // for navigation
    static let tag = ViewTags.OnboardingView
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
                        }
                        
                    }
                    
                        
                    Button {
                        let (isValid, errorMsg) = memberProfile.validateFirstName()
                        
                        if !isValid {
                            // show error message
                            self.alertMsg = errorMsg
                            self.showAlert = true
                        } else {
                            // save to profile
                            self.memberProfile.saveProfile()
                            
                            // go to next page
                            path.append(ViewTags.Onboarding2View)
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
//                let _ = print(tag)
                if tag == ViewTags.HomeView {
                    HomeView(path:$path, memberProfile: memberProfile)
//                    HomeView(memberProfile: memberProfile)
                } else if tag == ViewTags.Onboarding2View {
                    Onboarding2View(path: $path, memberProfile: memberProfile)
                } else if tag == ViewTags.Onboarding3View {
                    Onboarding3View(path: $path, memberProfile: memberProfile)
                } else {
//                    TempSample2()
                }
            }
            
            .onAppear {
                // if logged in, move to menu
                if self.memberProfile.isLoggedIn {
                    path.append(ViewTags.HomeView)
                }
            }
        }
    }
}


struct Onboarding2View: View {
    // for navigation
    static let tag = ViewTags.Onboarding2View
    @Binding var path: NavigationPath
    
    // for member profile
    @ObservedObject var memberProfile: MemberProfileModel
        
    // for alert box
    @State private var showAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
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
                        
                        NamedTextField(text:  $memberProfile.lastName, title: "Last Name")
                            .autocorrectionDisabled()
                    }
                    
                }
                
                HStack {
                    Button {
                        path.removeLast()
                    } label: {
                        Text("Back")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                    
                    Button {
                        let (isValid, errorMsg) = memberProfile.validateLastName()
                        
                        if !isValid {
                            // show error message
                            self.alertMsg = errorMsg
                            self.showAlert = true
                        } else {
                            // save to profile
                            self.memberProfile.saveProfile()
                            
                            // go to next page
                            path.append(ViewTags.Onboarding3View)
                        }
                    } label: {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                }
                
            }
            .alert(alertMsg, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .padding(10)
            .navigationBarHidden(true)
        }
    }
}


struct Onboarding3View: View {
    // for navigation
    static let tag = ViewTags.Onboarding3View
    @Binding var path: NavigationPath
    
    // for member profile
    @ObservedObject var memberProfile: MemberProfileModel
        
    // for alert box
    @State private var showAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
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

                        NamedTextField(text:  $memberProfile.email, title: "Email")
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                    
                }
                
                HStack {
                    Button {
                        path.removeLast()
                    } label: {
                        Text("Back")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                    
                    Button {
                        let (isValid, errorMsg) = memberProfile.validateEmail()
                        
                        if !isValid {
                            // show error message
                            self.alertMsg = errorMsg
                            self.showAlert = true
                        } else {
                            // save to profile
                            self.memberProfile.completedProfile()
                            
                            // go to next page
                            path.append(ViewTags.HomeView)
                        }
                    } label: {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(DarkButton())
                }
                
            }
            .alert(alertMsg, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .padding(10)
            .navigationBarHidden(true)
        }
    }
}
