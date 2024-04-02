//
//  MemberModel.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/4/2024.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class MemberProfileModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var emailOptionOrderStatus:Bool = false
    @Published var emailOptionPasswordChanges:Bool = false
    @Published var emailOptionSpecialOffer:Bool = false
    @Published var emailOptionNewsletter:Bool = false
    
    @Published private(set) var isLoggedIn: Bool = false
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    @Published private(set) var imageState: ImageState = .empty
    @Published private(set) var imageStateEdit: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                // load to temp first
                let progress = loadPhotoPickerImage(imageSelection: imageSelection, fileName: "temp")
                self.imageStateEdit = .loading(progress)
            } else {
                self.imageStateEdit = .empty
            }
        }
    }
    
    private var fileManager: FileManager = FileManager()
    private var bProfileImageEdited: Bool = false
    
    init() {
        self.loadProfile()
    }
    
    public func loadProfile() {
        self.loadFromUserDefault()
        self.loadProfileImage()
        self.bProfileImageEdited = false
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
        
        // save profile image from edit
        self.saveProfileImage()
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
        
        self.imageStateEdit = .empty
        self.imageState = .empty
        
        self.saveProfile()
    }
    
    private func loadFromUserDefault() {
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
    
    public func hasProfileBeenEdited() -> Bool {
        let firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
        let email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
        
        let emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
        let emailOptionPasswordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
        let emailOptionSpecialOffer = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
        let emailOptionNewsletter = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionNewsletter)
        
        guard firstName == self.firstName,
              lastName == self.lastName,
              email == self.email,
              phoneNumber == self.phoneNumber,
              emailOptionOrderStatus == self.emailOptionOrderStatus,
              emailOptionPasswordChanges == self.emailOptionPasswordChanges,
              emailOptionSpecialOffer == self.emailOptionSpecialOffer,
              emailOptionNewsletter == self.emailOptionNewsletter,
              !bProfileImageEdited else {
            return true
        }
        return false
    }
        
    // handle profile image
    public func saveProfileImage() {
        switch self.imageStateEdit {
        case .empty:
            // profile already removed
            self.fileManager.deleteImage(fileName: "profile")
            self.fileManager.deleteImage(fileName: "temp")
            self.imageState = .empty
            break
        case .success:
            // if selected
            if let uiImage = self.fileManager.retrieveImage(fileName: "temp") {
                self.fileManager.saveImage(fileName: "profile", image: uiImage)
                
                // load to imageState
                self.imageState = .success(Image(uiImage: uiImage))
                self.imageStateEdit = .success(Image(uiImage: uiImage))
                
                self.fileManager.deleteImage(fileName: "temp")
            }
        default:
            // unknown reason
            self.fileManager.deleteImage(fileName: "temp")
            self.fileManager.deleteImage(fileName: "profile")
            
            self.imageState = .empty
            self.imageStateEdit = .empty
            break
        }
        self.bProfileImageEdited = false
    }
    
    private func loadProfileImage() {
        self.fileManager.deleteImage(fileName: "temp")
        guard let uiImage = self.fileManager.retrieveImage(fileName: "profile") else {
            self.imageState = .empty
            self.imageStateEdit = .empty
            return
        }
        let profileImage = Image(uiImage: uiImage)
        self.imageState = .success(profileImage)
        self.imageStateEdit = .success(profileImage)
    }
    
    public func removeProfileImageFromEdit() {
        self.imageStateEdit = .empty
        self.bProfileImageEdited = true
    }
    
    private func loadPhotoPickerImage(imageSelection: PhotosPickerItem, fileName: String) -> Progress {
        imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let loaded?):
                    if let uiImage = UIImage(data: loaded) {
                        let profileImage = Image(uiImage: uiImage)
                        self.fileManager.saveImage(fileName: fileName, image: uiImage)
                        self.imageStateEdit = .success(profileImage)
                        self.bProfileImageEdited = true
                    } else {
                        self.imageStateEdit = .empty
                    }
                case .success(nil):
                    self.imageStateEdit = .empty
                case .failure(let error):
                    self.imageStateEdit = .failure(error)
                }
            }
        }
    }
    
    
    // form validation
    
    public func validateText() -> (Bool, String) {
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
