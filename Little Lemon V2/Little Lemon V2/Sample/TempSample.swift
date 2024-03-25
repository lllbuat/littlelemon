//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {

    var body: some View {    
        NavigationStack {
            VStack {
                Text("Hello, world!")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavBarToolBarContent()
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        print("back")
//                    } label: {
//                        Image(systemName: "arrow.left.circle.fill")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 30, alignment: .center)
//                            .foregroundStyle(Colors.DarkGreen)
//                    }
//                }
//                
//                ToolbarItem(placement: .principal) {
//                    Image("littleLemon")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 50, alignment: .center)
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        print("profile")
//                    } label: {
//                        Image("profile-image-placeholder")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 50, alignment: .center)
//                    }
//                }
            }
        }
    }
}




#Preview {
    TempSample()
}

