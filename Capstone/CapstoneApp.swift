//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 5/16/24.
//

import SwiftUI

@main
struct CapstoneApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
