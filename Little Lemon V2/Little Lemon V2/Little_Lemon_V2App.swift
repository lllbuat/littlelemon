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
            OnboardingProfileView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            OnboardingReview().environment(\.managedObjectContext, persistenceController.container.viewContext)
//            TempSample()
//            TempSample2()
            
//            TempSample().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            TempSample2().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            FontFamilySample()
            
//            UserProfile()
            
//            Menu().environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
