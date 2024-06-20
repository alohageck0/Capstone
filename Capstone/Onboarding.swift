//
//  Onboarding.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 5/24/24.
//

import SwiftUI

//let kFirstName = "first name key"
//let kLastName = "last name key"
//let kEmail = "email key"

struct Onboarding: View {
    static let kIsLoggedIn = "kIsLoggedIn"
    private let firstName = UserDefaults.standard.object(forKey: kFirstName) as? String ?? "Empty first name"
    private let lastName = UserDefaults.standard.object(forKey: kLastName) as? String ?? "Empty last name"
    private let email = UserDefaults.standard.object(forKey: kEmail) as? String ?? "Empty email"
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.secondary_white
                
                VStack {
                    Image.logo
                        .padding(.top, 80)
                    Spacer()
                }
                VStack {
//                    TextField("First Name", text: $firstName)
//                        .textFieldStyle(.roundedBorder)
//                    TextField("Last Name", text: $lastName)
//                        .textFieldStyle(.roundedBorder)
//                    TextField("Email", text: $email)
//                        .textFieldStyle(.roundedBorder)
                    Text("Review your input")
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
                        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
//                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: Self.kIsLoggedIn)
                            isLoggedIn = true
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
                    .navigationDestination(isPresented: $isLoggedIn) {
                        Home()
                    }
                }
                .onAppear {
                    if UserDefaults.standard.bool(forKey: Self.kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
                .padding(50)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Onboarding()
}
