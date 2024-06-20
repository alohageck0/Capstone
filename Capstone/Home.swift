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
        TitleView()
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

struct TitleView: View {
    var body: some View {
        ZStack {
            HStack {
                Image.logo
            }
            HStack {
                Spacer()
                Image.profile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    Home()
}
