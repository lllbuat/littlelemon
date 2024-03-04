//
//  UserProfile.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 4/3/2024.
//

import SwiftUI

struct UserProfile: View {
    private let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    private let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    private let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
