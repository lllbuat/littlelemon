//
//  UserProfileImageView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 2/4/2024.
//

import SwiftUI
import PhotosUI

struct UserProfileImageView: View {
    let imageState: MemberProfileModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.white)
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct CircularUserProfileImageView: View {
    let imageState: MemberProfileModel.ImageState
    var size: CGFloat = 100
    
    var body: some View {
        UserProfileImageView(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: self.size, height: self.size)
            .background {
                Circle().fill(Colors.DarkGreen)
            }
    }
}
