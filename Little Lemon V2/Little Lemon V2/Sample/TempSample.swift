//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State private var path: [Int] = [] // Nothing on the stack by default.

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink("Purple", value: 1)
                    .buttonStyle(LightButton())
            }
            .navigationDestination(for: Int.self) { i in
                Text("View " + String(i))
            }
        }
    }
}

struct ColorDetail: View {
    @Binding var path: [Color]
    let color: Color

    var body: some View {
        VStack {
            color
                .ignoresSafeArea()
            Text("Path " + String(path.count))
            Button("Pop") {
                path.removeLast()

            }
        }
    }
}

#Preview {
    TempSample()
}

