//
//  TempSample2.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 28/3/2024.
//

import SwiftUI

struct TempSample2: View {
    @State private var navPath: [String] = []

    var body: some View {
        Text("test")
    }
}

struct View1: View {
    @Binding var path: [String]

    var body: some View {
        VStack {
            Text("View 1")
            NavigationLink("Go to View2", value: "2")
                .buttonStyle(LightButton())
            Button("Pop") {
                path.removeLast()
            }
        }
    }
}

struct View2: View {
    @Binding var path: [String]

    var body: some View {
            VStack {
                Text("View 2")
                NavigationLink("Go to View3", value: "3")
                    .buttonStyle(LightButton())
                Button("Pop") {
                    path.removeLast()
                }
            }
    }
}

struct View3: View {
    @Binding var path: [String]

    var body: some View {
            VStack {
                Text("Unknown")
                Button("Pop") {
                    path.removeLast()
                }
                Button("Pop to root") {
                    path.removeAll()
                }
            }
    }
}

struct SampleView: View {
    @Binding var path: NavigationPath

    var body: some View {
            VStack {
                Text("Unknown")
                Button("Pop") {
                    path.removeLast()
                }
                Button("Pop to root") {
                    path.removeLast(path.count)
                }
            }
    }
}
