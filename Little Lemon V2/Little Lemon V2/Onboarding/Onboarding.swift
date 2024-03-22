//
//  Onboarding.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/3/2024.
//

import SwiftUI

//let kFirstName = "key_firstName"
//let kLastName = "key_lastName"
//let kEmail = "key_Email"
//let kIsLoggedIn = "key_IsLoggedIn"

struct Onboarding: View {
    @State private var showAlert = false
    @State private var isLoggedIn = false
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Image("littleLemon")
                
                TextField("First Name",
                          text: $firstName)
                TextField("Last Name",
                          text: $lastName)
                TextField("Email",
                          text: $email)
                Button(action: {
                    if (firstName.isEmpty) || (lastName.isEmpty) || (email.isEmpty) {
                        self.showAlert = true
                    } else {
                        UserDefaults.standard.set(firstName, forKey: UserDefaultsKeys.kFirstName)
                        UserDefaults.standard.set(lastName, forKey: UserDefaultsKeys.kLastName)
                        UserDefaults.standard.set(email, forKey: UserDefaultsKeys.kEmail)
                        self.isLoggedIn = true
                        UserDefaults.standard.set(isLoggedIn, forKey: UserDefaultsKeys.kIsLoggedIn)
                    }
                }, label: {
                    Text("Register")
                })
            }
            .padding()
            .alert("Empty First Name/Last Name/Email",
                   isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
           .navigationDestination(isPresented: $isLoggedIn) {
              Home()
           }
           .onAppear {
               self.isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.kIsLoggedIn)
               self.firstName = ""
               self.lastName = ""
               self.email = ""
           }
        }


            
    }
}

#Preview {
    Onboarding()
}
