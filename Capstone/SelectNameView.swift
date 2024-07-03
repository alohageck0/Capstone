////
////  SelectNameView.swift
////  Capstone
////
////  Created by Evgenii Iavorovich on 6/13/24.
////
//
//import SwiftUI
//
////let kFirstName = "first name key"
////let kLastName = "last name key"
////let kEmail = "email key"
//
//struct SelectNameView: View {
//    static let kIsLoggedIn = "kIsLoggedIn"
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @State private var email = ""
//    @State private var isLoggedIn = false
//    @State private var canContinue = false
//    
//    var body: some View {
//        TitleView(isLoggedIn: $isLoggedIn)
//            .frame(height: 50)
//        NavigationStack {
//            ZStack {
//                VStack {
//                    Text("What's your name?")
//                        .sectionCategory()
//                    TextField("First Name", text: $firstName)
//                        .textFieldStyle(.roundedBorder)
//                    TextField("Last Name", text: $lastName)
//                        .textFieldStyle(.roundedBorder)
//                    Button {
//                        if !firstName.isEmpty && !lastName.isEmpty {
//                            UserDefaults.standard.set(firstName, forKey: kFirstName)
//                            UserDefaults.standard.set(lastName, forKey: kLastName)
////                            UserDefaults.standard.set(email, forKey: kEmail)
////                            UserDefaults.standard.set(true, forKey: Self.kIsLoggedIn)
//                            canContinue = true
//                        }
//                    } label: {
//                        Text("Next")
//                            .foregroundStyle(.secondary_white)
//                            .padding(5)
//                            .background(.primary_green)
//                            .clipShape(
//                                RoundedRectangle(cornerRadius: 5)
//                            )
//                    }
//                    .navigationDestination(isPresented: $isLoggedIn) {
//                        Home()
//                    }
//                }
//                .onAppear {
//                    if UserDefaults.standard.bool(forKey: Self.kIsLoggedIn) {
//                        debugPrint("evv kIsLoggedIn")
//                        isLoggedIn = true
//                    }
//                }
//                .padding(50)
//            }
//            .ignoresSafeArea()
//        }
//        .tint(.primary_green)
//    }
//}
//
////struct TitleView: View {
////    @Binding var isLoggedIn: Bool
////    
////    var body: some View {
////        ZStack {
////            HStack {
////                Image.logo
////            }
////            if isLoggedIn {
////                HStack {
////                    Spacer()
////                    Image.profile
////                        .resizable()
////                        .scaledToFit()
////                        .frame(width: 50)
////                        .padding(.trailing, 20)
////                }
////            }
////        }
////    }
////}
//
//#Preview {
//    SelectNameView()
//}
