//
//  NavBarView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct NavBarView: View {
    let persistence = PersistenceController.shared
    @Environment(\.presentationMode) var presentation
    
    @State var showBackBtn: Bool = true
    @State var showProfileBtn: Bool = true
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .center) {
                
                Button {
                    self.presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30, alignment: .center)
                        .foregroundStyle(Colors.DarkGreen)
                }
                .opacity(self.showBackBtn ? 1 : 0)
                .disabled(self.showBackBtn ? false : true)
                
                
                Spacer()
                
                Image("littleLemon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50, alignment: .center)
                
                Spacer()
                
                NavigationLink(destination: UserProfile()) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50, alignment: .center)
                }
                .opacity(self.showProfileBtn ? 1 : 0)
                .disabled(self.showProfileBtn ? false : true)
            }
        }
    }
}

#Preview {
    NavBarView()
}
