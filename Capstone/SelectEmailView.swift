//
//  SelectEmailView.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/13/24.
//

import SwiftUI

//let kFirstName = "first name key"
//let kLastName = "last name key"
let kEmail = "email key"

struct SelectEmailView: View {
    static let kIsLoggedIn = "kIsLoggedIn"
//    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    private let firstName = UserDefaults.standard.object(forKey: kFirstName) as? String ?? "first_name"
    var body: some View {
        NavigationStack {
            ZStack {
                Color.secondary_white
                
                VStack {
                    Image.logo
                        .padding(.top, 100)
                    Spacer()
                }
                VStack {
//                    TextField("First Name", text: $firstName)
//                        .textFieldStyle(.roundedBorder)
//                    TextField("Last Name", text: $lastName)
//                        .textFieldStyle(.roundedBorder)
                    Text("Hi \(firstName), please share your email address")
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        if !email.isEmpty {
//                            UserDefaults.standard.set(firstName, forKey: kFirstName)
//                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
//                            UserDefaults.standard.set(true, forKey: Self.kIsLoggedIn)
                            isLoggedIn = true
                        }
                    } label: {
                        Text("Next")
                            .foregroundStyle(.secondary_white)
                            .padding(5)
                            .background(.primary_green)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                    }
                    .navigationDestination(isPresented: $isLoggedIn) {
                        Onboarding()
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
    SelectEmailView()
}
