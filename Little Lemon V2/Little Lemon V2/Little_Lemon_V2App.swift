//
//  Little_Lemon_V2App.swift
//  Little Lemon V2
//
//  Created by Renee Lo on 1/3/2024.
//

import SwiftUI

@main
struct Little_Lemon_V2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            Home()
//            OnboardingProfile()
//            OnboardingReview()
            TempSample()
            
//            TempSample()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            FontFamilySample()
//            UserProfile()
//            Menu()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            Onboarding()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
