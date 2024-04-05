//
//  HomeView.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 5/4/2024.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @ObservedObject var memberProfile: MemberProfileModel
    
    @State var selectedTab: String = ViewTags.MenuViewV2
    @State var popToRoot: Bool = false
    
    var body: some View {
        NavBarViewV2(path: $path, memberProfile: memberProfile, showBackBtn: false, profileBtnHandler: {
            self.selectedTab = ViewTags.UserProfileViewV2
        })
        
        TabView(selection: $selectedTab) {
            MenuViewV2(memberProfile: memberProfile)
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(ViewTags.MenuViewV2)
            UserProfileViewV2(popToRoot: $popToRoot, memberProfile: memberProfile)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
                .tag(ViewTags.UserProfileViewV2)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: self.popToRoot) {
            path.removeLast(path.count)
        }
        .onChange(of: self.selectedTab) {
            if self.memberProfile.hasProfileBeenEdited() {
                print("editing")
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
