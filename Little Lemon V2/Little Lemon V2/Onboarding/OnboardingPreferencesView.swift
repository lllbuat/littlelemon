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
        
    @ObservedObject var memberProfile: MemberProfileModel
    
    var body: some View {
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
                            Toggle("Order status", isOn: $memberProfile.emailOptionOrderStatus)
                            Toggle("Password changes", isOn: $memberProfile.emailOptionPasswordChanges)
                            Toggle("Special offers", isOn: $memberProfile.emailOptionSpecialOffer)
                            Toggle("Newsletter", isOn: $memberProfile.emailOptionNewsletter)
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
                        // save profile
                        self.memberProfile.saveProfile()
                        
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
