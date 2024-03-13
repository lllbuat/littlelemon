//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var test: String = "Hello World"
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    var body: some View {
        VStack {
            Button("Change") {
                // open photo library to select image
            }
            
            avatarImage?
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
        }

        
//        Text(test)
        
//        VStack {
//            TextField(test, text: $test)
//                .font(Font(Fonts.ParagraphText))
//                .foregroundStyle(Colors.DarkGray)
//                .padding(10)
//                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Colors.DarkGray, style: StrokeStyle(lineWidth: 0.5)))
//        }
//        .padding([.top, .bottom], 10)
//        .padding([.leading, .trailing], 20)
    }
}

#Preview {
    TempSample()
}
