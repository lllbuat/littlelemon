//
//  NavBarView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
        HStack {
            Button {
//                presentation.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30, alignment: .center)
                    .foregroundStyle(Colors.DarkGreen)
            }
            
            Spacer()
            
            Image("littleLemon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50, alignment: .center)
            
            Spacer()
            
            Button {
                print("profile")
            } label: {
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50, alignment: .center)
            }
        }
    }
}

#Preview {
    NavBarView()
}
