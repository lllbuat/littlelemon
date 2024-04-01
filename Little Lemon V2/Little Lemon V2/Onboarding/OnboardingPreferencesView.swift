//
//  OnboardingPreferences.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 22/3/2024.
//

import SwiftUI

struct OnboardingPreferencesView: View {
    static let tag = ViewTags.OnboardingPreferencesView
    @Binding var path: NavigationPath
        
    @State private var emailOptionOrderStatus = false
    @State private var emailOptionPasswordChanges = false
    @State private var emailOptionSpecialOffer = false
    @State private var emailOptionNewsletter = false
    
    var body: some View {
//        let _ = print("OnboardingPreferences")
        VStack {
            NavBarView(path: $path, showBackBtn: false, showProfileBtn: false)
            
            HeroSectionView()
                .frame(height: 300)
                            
            VStack {
                ScrollView(.vertical) {
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
                        path.removeLast()
                    } label: {
                        Text("Back")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(LightButton())
                    
                    Button {
                        UserDefaults.standard.set(emailOptionOrderStatus, forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
                        UserDefaults.standard.set(emailOptionPasswordChanges, forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
                        UserDefaults.standard.set(emailOptionSpecialOffer, forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
                        UserDefaults.standard.set(emailOptionNewsletter, forKey: UserDefaultsKeys.kEmailOptionNewsletter)
                        
                        path.append(ViewTags.OnboardingReviewView)
                    } label: {
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

//#Preview {
//    OnboardingPreferences()
//}
