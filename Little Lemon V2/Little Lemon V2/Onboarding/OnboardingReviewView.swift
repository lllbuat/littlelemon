//
//  OnboardingReview.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct OnboardingReviewView: View {
    static let tag = ViewTags.OnboardingReviewView
    @Binding var path: NavigationPath
    
    @ObservedObject var memberProfile: MemberProfileModel
    
    var body: some View {
        VStack {
            NavBarView(path: $path, memberProfile: memberProfile, showBackBtn: false, showProfileBtn: false)
            
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
                        
                        NamedText(text: memberProfile.firstName, title: "First Name")
                        NamedText(text: memberProfile.lastName, title: "Last Name")
                        NamedText(text: memberProfile.email, title: "Email")
                        NamedText(text: memberProfile.phoneNumber, title: "Phone Number")
                        
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
                        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        
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
                        self.memberProfile.completedProfile()
                        
                        path.append(ViewTags.MenuView)
                    } label: {
                        Text("Register")
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
//    OnboardingReview()
//}
