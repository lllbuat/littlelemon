//
//  UserProfile.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 4/3/2024.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
    @State private var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
    @State private var emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
    
    
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
                Image("profile-image-placeholder")
                
                Button("Change") { }
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .font(Font(Fonts.LeadText))
                    .foregroundColor(.white)
                    .background(Colors.DarkGreen)
                    .cornerRadius(10)
                
                Button("Remove") { }
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .font(Font(Fonts.LeadText))
                    .foregroundColor(Colors.DarkGray)
                    .background(.white)
                    .border(Colors.DarkGreen)
            }

            List {
                Section(header: Text("First name")
                    .font(Font(Fonts.HighlightText))
                    .foregroundStyle(Colors.Gray)
                ) {
                    TextField(firstName, text: $firstName)
                        .font(Font(Fonts.ParagraphText))
                }
                
                Section(header: Text("Last name")
                    .font(Font(Fonts.HighlightText))
                    .foregroundStyle(Colors.Gray)
                ) {
                    TextField(lastName, text: $lastName)
                        .font(Font(Fonts.ParagraphText))
                }
            }
//            .listStyle(.sidebar)
//            .scrollContentBackground(.hidden)
//            .background(.red)

            

            
            Text("Email")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.Gray)
            
            TextField(email, text: $email)
                .font(Font(Fonts.ParagraphText))
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
            
            Text("Phone number")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.Gray)
            
            TextField(phoneNumber, text: $phoneNumber)
                .font(Font(Fonts.ParagraphText))
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
                
            Text("Email Notifications")
                .font(Font(Fonts.CardTitle))
                .foregroundStyle(Colors.DarkGray)
            // checkboxes
            Toggle("Order Status", isOn: $emailOptionOrderStatus)
                .toggleStyle(CheckboxStyle())
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 15)
            .font(Font(Fonts.LeadText))
            .foregroundColor(Colors.DarkGray)
            .background(Colors.Yellow)
            .cornerRadius(10)
            
            HStack {
                Button("Disgard changes") {
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .font(Font(Fonts.LeadText))
                .foregroundColor(Colors.DarkGray)
                .background(.white)
                .border(Colors.DarkGreen)
                
                Button("Save changes") {
                }
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 15)
                .font(Font(Fonts.LeadText))
                .foregroundColor(.white)
                .background(Colors.DarkGreen)
                .cornerRadius(10)
            }
        }
//        .background(.green)
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
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
