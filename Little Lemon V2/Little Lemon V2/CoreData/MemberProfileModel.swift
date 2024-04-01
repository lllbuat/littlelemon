//
//  MemberModel.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/4/2024.
//

import Foundation

class MemberProfileModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var emailOptionOrderStatus:Bool = false
    @Published var emailOptionPasswordChanges:Bool = false
    @Published var emailOptionSpecialOffer:Bool = false
    @Published var emailOptionNewsletter:Bool = false
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        self.loadFromUserDefault()
    }
    
    public func validateText() -> (Bool, String){
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
            
            let fieldAlertText = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidPhoneMessage)\(invalidEmailMessage)"
            
            return (false, fieldAlertText)
        }
        
        return (true, "")
    }
    
    public func saveProfile() {
        UserDefaults.standard.set(self.firstName, forKey: UserDefaultsKeys.kFirstName)
        UserDefaults.standard.set(self.lastName, forKey: UserDefaultsKeys.kLastName)
        UserDefaults.standard.set(self.email, forKey: UserDefaultsKeys.kEmail)
        UserDefaults.standard.set(self.phoneNumber, forKey: UserDefaultsKeys.kPhoneNumebr)
        
        UserDefaults.standard.set(self.emailOptionOrderStatus, forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
        UserDefaults.standard.set(self.emailOptionPasswordChanges, forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
        UserDefaults.standard.set(self.emailOptionSpecialOffer, forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
        UserDefaults.standard.set(self.emailOptionNewsletter, forKey: UserDefaultsKeys.kEmailOptionNewsletter)
        
        UserDefaults.standard.set(self.isLoggedIn, forKey: UserDefaultsKeys.kIsLoggedIn)
    }
    
    public func completedProfile() {
        self.isLoggedIn = true
        self.saveProfile()
    }
    
    public func clearProfile() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phoneNumber = ""
        
        self.emailOptionOrderStatus = false
        self.emailOptionPasswordChanges = false
        self.emailOptionSpecialOffer = false
        self.emailOptionNewsletter = false
        
        self.isLoggedIn = false
        
        self.saveProfile()
    }
    
    public func loadFromUserDefault() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
        
        if self.isLoggedIn {
            self.firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
            self.lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
            self.email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
            self.phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
            
            self.emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
            self.emailOptionPasswordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
            self.emailOptionSpecialOffer = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
            self.emailOptionNewsletter = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionNewsletter)
        } 
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
