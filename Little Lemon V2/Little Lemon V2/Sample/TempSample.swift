//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink("Go to View1", value: "1")
            }
            .navigationDestination(for: String.self) { pathValue in
                if pathValue == "1" {
                    View1(path: $path)
                } else if pathValue == "2" {
                    View2(path: $path)
                } else if pathValue == "3" {
                    View3(path: $path)
                }
            }
        }

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
//        .navigationDestination(for: String.self) { pathValue in
//            if pathValue == "2" {
//                View2(path: $path)
//            } else if pathValue == "3" {
//                View3(path: $path)
//            }
//        }

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
//            .navigationDestination(for: String.self) { pathValue in
//                View3(path: $path)
//            }
    }
}

struct View3: View {
    @Binding var path: [String]

    var body: some View {
            VStack {
                Text("View 3")
                Button("Pop") {
                    path.removeLast()
                }
                Button("Pop to root") {
                    path.removeAll()
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

