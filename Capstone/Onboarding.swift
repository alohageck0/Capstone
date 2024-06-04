//
//  Onboarding.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 5/24/24.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        ZStack {
            Color.secondary_white
            
            VStack {
                Image.logo
                    .padding(.top, 100)
                Spacer()
            }
            VStack {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                    }
                } label: {
                    Text("Register")
                        .foregroundStyle(.secondary_white)
                        .padding(5)
                        .background(.primary_green)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                }
            }
            .padding(50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Onboarding()
}
