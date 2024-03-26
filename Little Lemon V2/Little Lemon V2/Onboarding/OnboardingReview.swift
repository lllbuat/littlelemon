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
    
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
    
    @State private var firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
    @State private var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
    
    @State private var emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
    @State private var emailOptionPasswordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
    @State private var emailOptionSpecialOffer = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
    @State private var emailOptionNewsletter = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionNewsletter)
    
    var body: some View {
        NavigationStack{
            VStack {
                NavBarView(showBackBtn: false, showProfileBtn: false)
                
                HeroSectionView()
                    .frame(height: 300)
                
                VStack {
                    ScrollView(.vertical) {
                        VStack(spacing: 15) {
                            Text("Review")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textCase(.uppercase)
                                .font(Font(Fonts.SectionTitle))
                            
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
                        
                        
                        Button {
                            UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.kFirstName)
                            UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.kLastName)
                            UserDefaults.standard.set(email, forKey: UserDefaultsKeys.kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: UserDefaultsKeys.kPhoneNumebr)
                            
                            UserDefaults.standard.set(emailOptionOrderStatus, forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
                            UserDefaults.standard.set(emailOptionPasswordChanges, forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
                            UserDefaults.standard.set(emailOptionSpecialOffer, forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
                            UserDefaults.standard.set(emailOptionNewsletter, forKey: UserDefaultsKeys.kEmailOptionNewsletter)
                            
                            self.isLoggedIn = true
                            UserDefaults.standard.set(isLoggedIn, forKey: UserDefaultsKeys.kIsLoggedIn)
                        } label: {
                            Text("Register")
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(DarkButton())
                        
//                        NavigationLink(destination: Menu()
//                            .environment(\.managedObjectContext, persistence.container.viewContext)) {
//                            Text("Register")
//                                .frame(maxWidth: .infinity)
//                        }.buttonStyle(DarkButton())
                    }
                }
                .padding(10)
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $isLoggedIn) {
                    Menu()
                }
            }
        }
    }
}


#Preview {
    OnboardingReview()
}
