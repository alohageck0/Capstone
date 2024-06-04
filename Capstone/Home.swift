//
//  Home.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/4/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem { Label( "Menu", systemImage:  "list.dash") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
