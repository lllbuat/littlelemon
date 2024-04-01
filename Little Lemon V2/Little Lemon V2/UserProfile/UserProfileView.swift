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
    
    @ObservedObject var memberProfile: MemberProfileModel
    
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
    
//    @State private var firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kFirstName) ?? ""
//    @State private var lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.kLastName) ?? ""
//    @State private var email = UserDefaults.standard.string(forKey: UserDefaultsKeys.kEmail) ?? ""
//    @State private var phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.kPhoneNumebr) ?? ""
//    
//    @State private var emailOptionOrderStatus = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionOrderStatus)
//    @State private var emailOptionPasswordChanges = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionPasswordChanges)
//    @State private var emailOptionSpecialOffer = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionSpecialOffer)
//    @State private var emailOptionNewsletter = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kEmailOptionNewsletter)
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image = Image("profile-image-placeholder")/*Image(systemName: "person")*/
    
    @State private var alertText = ""
    @State private var showAlert = false
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
                    
                    NamedTextField(text: $memberProfile.firstName, title: "First Name")
                    NamedTextField(text: $memberProfile.lastName, title: "Last Name")
                    NamedTextField(text: $memberProfile.email, title: "Email")
                        .textInputAutocapitalization(.never)
                    NamedTextField(text: $memberProfile.phoneNumber, title: "Phone Number")
                    
                    SectionTitleView(title: "Email Notifications")
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
            
            Button {
                // reset all user default values
                self.memberProfile.clearProfile()
                
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
                    let (isValid, errorMsg) = self.memberProfile.validateText()
                    if !isValid {
                        // show error msg
                        self.alertText = errorMsg
                        self.showAlert = true
                    } else {
                        // save profile
                        self.memberProfile.saveProfile()
                        
                        // show saved msg
                        self.alertText = "Profile saved!"
                        self.showAlert = true
                    }
                } label: {
                    Text("Save changes")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DarkButton())
                .alert(self.alertText, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding(10)
        .onAppear {
            self.memberProfile.loadFromUserDefault()
        }
    }
}

//#Preview {
//    UserProfile()
//}


