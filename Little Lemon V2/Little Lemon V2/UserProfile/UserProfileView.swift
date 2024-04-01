//
//  UserProfile.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 4/3/2024.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @Binding var path: NavigationPath
    
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
    @State private var avatarImage: Image = Image("profile-image-placeholder")/*Image(systemName: "person")*/
    
    @State private var fieldAlertText = ""
    @State private var showFieldAlert = false
    @State private var showDisgardConfirmAlert = false    
    
    var body: some View {
        VStack {
            NavBarView(path: $path, showProfileBtn: false)
            
            SectionTitleView(title: "Personal Information")
            
            Text("Avatar")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font(Fonts.HighlightText))
                .foregroundStyle(Colors.Gray)
            
            HStack {
                avatarImage
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                                    
                Button {
                    // change avatar
                } label: {
                    Text("Change")
                }.buttonStyle(DarkButton())
                
                Button {
                    // remove avatar
                } label: {
                    Text("Remove")
                }.buttonStyle(LightButton())
                
                Spacer()
            }
                                            
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 5) {
                    SectionTitleView(title: "Profile")
                    
                    NamedTextField(text: $firstName, title: "First Name")
                    NamedTextField(text: $lastName, title: "Last Name")
                    NamedTextField(text: $email, title: "Email")
                        .textInputAutocapitalization(.never)
                    NamedTextField(text: $phoneNumber, title: "Phone Number")
                    
                    SectionTitleView(title: "Email Notifications")
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
            
            Button {
                // reset all user default values
                UserDefaults.standard.set("", forKey: UserDefaultsKeys.kFirstName)
                UserDefaults.standard.set("", forKey: UserDefaultsKeys.kLastName)
                UserDefaults.standard.set("", forKey: UserDefaultsKeys.kEmail)
                UserDefaults.standard.set("", forKey: UserDefaultsKeys.kPhoneNumebr)
                
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kEmailOptionNewsletter)
                
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.kIsLoggedIn)
                
                path.removeLast(path.count)
            } label: {
                Text("Log out")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(YellowButton())
            
            HStack {
                Button {
                    // show alert and move to home
                    self.showDisgardConfirmAlert = true
                } label: {
                    Text("Disgard changes")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(LightButton())
                .alert(isPresented: $showDisgardConfirmAlert) {
                    Alert(
                        title: Text("Confirm to disgard?"),
                        message: Text("Changes to profile will not be saved."),
                        primaryButton: .default(
                            Text("Cancel"),
                            action: { }
                        ),
                        secondaryButton: .destructive(
                            Text("Confirm"),
                            action: {
                                path.removeLast()
                            }
                        )
                    )
                }
                
                Button {
                    self.validateForm()
                } label: {
                    Text("Save changes")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DarkButton())
                .alert(fieldAlertText, isPresented: $showFieldAlert) {
                    Button("OK", role: .cancel) { }
                }
            }


        }
        .navigationBarBackButtonHidden()
        .padding(10)
    }
    
    private func validateForm() {
        
        // name must contain just letters
        let firstNameIsValid = isValid(name: self.firstName)
        let lastNameIsValid = isValid(name: self.lastName)
        let emailIsValid = isValid(email: self.email)
        let phoneNumberIsValid = isValid(phone: self.phoneNumber)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid && phoneNumberIsValid
        else {
            var invalidFirstNameMessage = ""
            if !firstNameIsValid {
                invalidFirstNameMessage = "First name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if !lastNameIsValid {
                invalidLastNameMessage = "Last name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidPhoneMessage = ""
            if !phoneNumberIsValid {
                invalidPhoneMessage = "The phone number can only contain numbers and cannot be blank.\n\n"
            }
            
            var invalidEmailMessage = ""
            if !emailIsValid {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.fieldAlertText = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidPhoneMessage)\(invalidEmailMessage)"
            
            self.showFieldAlert.toggle()
            return
        }
        
        // save to user default
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
        
        self.fieldAlertText = "Profile Saved!"
        self.showFieldAlert.toggle()
    }
    
    private func isValid(name: String) -> Bool {
        guard !name.isEmpty, name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    private func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
        
    private func isValid(phone:String) -> Bool {
        guard !phoneNumber.isEmpty else { return false }
        let phoneValidationRegex = "^[0-9]+$"
        let phoneValidationPredicate = NSPredicate(format: "SELF MATCHES %@", phoneValidationRegex)
        return phoneValidationPredicate.evaluate(with: phoneNumber)
    }
}

//#Preview {
//    UserProfile()
//}


