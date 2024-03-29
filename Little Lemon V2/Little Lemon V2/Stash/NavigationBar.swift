//
//  NavigationBar.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 11/3/2024.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image("littleLemon")
                .resizable()
//                .aspectRatio(contentMode: .fit)
                .frame(width: 279.0, height: 55.0)
            Image("profile-image-placeholder")
                .resizable()
//                .aspectRatio(contentMode: .fill)
                .frame(width: 55.0, height: 55.0)
            Spacer()
        }
    }
}

#Preview {
    NavigationBar()
}
