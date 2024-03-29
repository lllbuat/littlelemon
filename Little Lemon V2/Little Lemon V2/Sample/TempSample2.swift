//
//  TempSample2.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 28/3/2024.
//

import SwiftUI

struct TempSample2: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    Menu()
                } label: {
                    Text("Go to Menu")
                }.buttonStyle(LightButton())
            }
        }
    }
}

//#Preview {
//    TempSample2()
//}
