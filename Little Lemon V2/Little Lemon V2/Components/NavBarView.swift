//
//  NavBarView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 25/3/2024.
//

import SwiftUI

struct NavBarView: View {
    static let tag = ViewTags.NavBarView
    @Binding var path: NavigationPath
    
    @ObservedObject var memberProfile: MemberProfileModel
    
    
    @State var showBackBtn: Bool = true
    @State var showProfileBtn: Bool = true
    var backBtnHandler: () -> Void = {}
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                self.backBtnHandler()
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
            
            Button {
                path.append(ViewTags.UserProfileView)
            } label: {
                CircularUserProfileImageView(imageState: memberProfile.imageState, size: CGFloat(50))
            }
            .opacity(self.showProfileBtn ? 1 : 0)
            .disabled(self.showProfileBtn ? false : true)
        }
        .padding([.horizontal], 10)
    }
}

//#Preview {
//    NavBarView()
//}
