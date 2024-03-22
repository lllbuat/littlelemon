//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var numClick: Int = 0
    @State var isActive = false
    
    var body: some View {    
        Button {
        } label: {
            Text("Sign Up")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(LightButton())
        
        Button("Light", systemImage: "digitalcrown.horizontal.press.fill") {
            incrementClick()
        }.buttonStyle(LightButton())
        
        Button("Dark", systemImage: "digitalcrown.horizontal.press.fill") {
            incrementClick()
        }.buttonStyle(DarkButton())
        
        Button {
            
        } label: {
            Text("Nothing")
                .frame(maxWidth: .infinity)
        } .buttonStyle(DarkButton())

        
        Button{
            // action will be here
        } label: {
            HStack {
                Image(systemName: "house.fill")
                Text("Button With Icon")
            }
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(.black)
            .cornerRadius(15)
            
        }
        
        Image(systemName: "house.fill")
            .frame(width: 52, height: 52)
            .foregroundColor(isActive ? .white : .black)
            .background(isActive ? .black : .clear)
            .cornerRadius(15)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black)
            }
            .onTapGesture {
                withAnimation {
                    isActive.toggle()
                }
            }
        
        Text(String(numClick))
    }
    
    func incrementClick() {
        self.numClick += 1
    }
}




#Preview {
    TempSample()
}
