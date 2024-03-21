//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var firstName = "Alice"
    @State private var lastName = "Bob"
    @State private var email = "hello@world.com"
    @State private var phoneNumber = "123-456-7890"
    
    var body: some View {
        VStack {
            HeroSectionView()
                .frame(height: 300)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    NamedTextField(text: $firstName, title: "First Name")
                    NamedTextField(text: $lastName, title: "Last Name")
                    NamedTextField(text: $email, title: "Email")
                    NamedTextField(text: $phoneNumber, title: "Phone Number")
                }
                .padding([.leading, .trailing], 10)
                .padding([.top, .bottom], 5)
                
                Spacer()
            }
        }
    }
}
    


#Preview {
    TempSample()
}
