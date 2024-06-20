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
                .sectionTitle()
                .foregroundStyle(.secondary_black)
                .padding(.bottom, 10)
            UserInfoField(title: "First name:", text: firstName)
            UserInfoField(title: "Last name:", text: lastName)
            UserInfoField(title: "Email:", text: email)
            
            Spacer()
            Button {
                UserDefaults.resetStandardUserDefaults()
                UserDefaults.standard.set(false, forKey: Onboarding.kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .foregroundStyle(.secondary_black)
                    .padding(5)
                    .background(.primary_yellow)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
            }
        }
        .padding(25)
    }
}

struct UserInfoField: View {
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Text(title)
                .paragraph()
                .foregroundStyle(.secondary_black)
            Text(text)
                .paragraph()
                .foregroundStyle(.secondary_black)
            Spacer()
        }
    }
}
#Preview {
    UserProfile()
}
