//
//  UserProfile.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 4/3/2024.
//

import SwiftUI
import PhotosUI

struct UserProfile: View {
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
    
    @State private var firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
    @State private var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
    
    @State private var emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
    @State private var emailOptionPasswordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
    @State private var emailOptionSpecialOffer = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
    @State private var emailOptionNewsletter = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionNewsletter)
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image = Image("profile-image-placeholder")
    
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.CardTitle))
                .foregroundStyle(Colors.DarkGray)
                .background(.white)
            
            Text("Avatar")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.Gray)
            
            HStack {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                
                Button("Change") { 
                    // open photo library to select image
                }
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .font(Font(Fonts.LeadText))
                    .foregroundColor(.white)
                    .background(Colors.DarkGreen)
                    .cornerRadius(10)
                
                Button("Remove") { 
                    // remove image from app
                }
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .font(Font(Fonts.LeadText))
                    .foregroundColor(Colors.DarkGray)
                    .background(.white)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGreen, style: StrokeStyle(lineWidth: 0.5)))
                Spacer()
            }
            
            Text("First name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            TextField(firstName, text: $firstName)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.Gray, style: StrokeStyle(lineWidth: 0.5)))
            
            Text("Last name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            TextField(lastName, text: $lastName)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.Gray, style: StrokeStyle(lineWidth: 0.5)))
            
            Text("Email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            TextField(email, text: $email)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.Gray, style: StrokeStyle(lineWidth: 0.5)))
            
            Text("Phone number")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.DarkGray)
            
            TextField(phoneNumber, text: $phoneNumber)
                .font(Font(Fonts.ParagraphText))
                .foregroundStyle(Colors.DarkGray)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.Gray, style: StrokeStyle(lineWidth: 0.5)))
            
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
            
            Button("Log out") {
                print("log out")
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 15)
            .frame(maxWidth: .infinity)
            .font(Font(Fonts.LeadText))
            .foregroundColor(Colors.DarkGray)
            .background(Colors.Yellow)
            .cornerRadius(10)
            
            HStack {
                Button("Disgard changes") {
                    // show alert and move to home
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .font(Font(Fonts.LeadText))
                .foregroundColor(Colors.DarkGray)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGreen, style: StrokeStyle(lineWidth: 0.5)))
                
                Button("Save changes") {
                    if (firstName.isEmpty) || (lastName.isEmpty) || (email.isEmpty) || (phoneNumber.isEmpty) {
                        self.showAlert = true
                    } else {
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
                    }
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .font(Font(Fonts.LeadText))
                .foregroundColor(.white)
                .background(Colors.DarkGreen)
                .cornerRadius(10)
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
        .alert("Empty First Name/Last Name/Email/Phone Number",
               isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    UserProfile()
}


struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? Colors.DarkGreen : .gray)
                .font(Font(Fonts.HighlightText))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}

