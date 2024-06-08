//
//  UserProfile.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/4/24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    
    private let firstName = UserDefaults.standard.object(forKey: kFirstName) as? String ?? "Empty first name"
    private let lastName = UserDefaults.standard.object(forKey: kLastName) as? String ?? "Empty last name"
    private let email = UserDefaults.standard.object(forKey: kEmail) as? String ?? "Empty email"
    
    var body: some View {
        VStack {
            Text("Personal information")
                .regular()
                .foregroundStyle(.secondary_black)
            Image.profile
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            Text(firstName)
                .sectionTitle()
                .foregroundStyle(.secondary_black)
            Text(lastName)
                .sectionTitle()
                .foregroundStyle(.secondary_black)
            Text(email)
                .sectionTitle()
                .foregroundStyle(.secondary_black)
            Button {
                UserDefaults.standard.set(false, forKey: Onboarding.kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .foregroundStyle(.secondary_white)
                    .padding(5)
                    .background(.primary_green)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
