//
//  Home.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/4/24.
//

import SwiftUI

struct Home: View {
    let persistenceController = PersistenceController.shared
    
    var body: some View {
//        TitleView(isLoggedIn: true)
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem { Label("Menu", systemImage:  "list.dash") }
            UserProfile()
                .tabItem { Label("Profile", systemImage: "square.and.pencil") }
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    Home()
}
