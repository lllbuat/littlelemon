//
//  TempSample.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 13/3/2024.
//

import SwiftUI
import PhotosUI

struct TempSample: View {
    @State var path: NavigationPath = .init()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink("Go to View1", value: "menu")
            }
            .navigationDestination(for: String.self) { tag in
                if tag == ViewTags.MenuView {
                    MenuView(path: $path)
                } else if tag == ViewTags.OnboardingProfileView {
                    OnboardingProfileView()
                } else if tag == ViewTags.OnboardingPreferencesView {
                    OnboardingPreferencesView(path: $path)
                } else if tag == ViewTags.OnboardingReviewView {
                    OnboardingReviewView(path: $path)
                } else if tag == ViewTags.UserProfileView {
                    UserProfileView(path: $path)
                } else {
                    SampleView(path: $path)
                }
            }
        }

    }
}




#Preview {
    TempSample()
}

