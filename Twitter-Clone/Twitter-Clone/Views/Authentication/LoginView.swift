//
//  LoginView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var emailDone: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var authVM: AuthViewModel = AuthViewModel()

    var body: some View {
        if !emailDone {
            VStack {
                VStack {
                    topBarView
                    gettingStartedTextView(text: "To get started first enter your phone, email, or @username")
                    authTextField(placeholderText: "Phone, email, or username", isSecure: false, text: $email)
                }
                Spacer(minLength: 0)
                nextButton
            }
        } else {
            VStack {
                VStack {
                    topBarView
                    gettingStartedTextView(text: "Password")
                    authTextField(placeholderText: "Password", isSecure: true, text: $password)
                }
                Spacer(minLength: 0)
                loginButton
            }
        }
        
    }

    private var topBarView: some View {
        ZStack {
            HStack {
                Button {
                    if email.isEmpty {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }

                Spacer()

            }.padding(.horizontal)

            Image("Twitter")
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)
            
        }
    }

    private func gettingStartedTextView(text: String) -> some View {
        Text(text)
            .font(.title2)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .padding([.horizontal, .top])
    }

    private func authTextField(placeholderText: String, isSecure: Bool, text: Binding<String>) -> some View {
        CustomAuthTextField(placeholder: placeholderText, isSecureTxtField: isSecure, text: text)
    }

    private var nextButton: some View {
        VStack {
            Button {
                self.emailDone.toggle()
            } label: {
                Capsule()
                    .frame(width: 360, height: 40, alignment: .center)
                    .foregroundColor(.backgroundblue)
                    .overlay {
                        Text("Next")
                            .foregroundColor(.white)
                    }
            }
            Text("Forgot Password?")
                .foregroundColor(.blue)
        }
        .padding(.bottom, 4)
    }

    private var loginButton: some View {
        VStack {
            Button {
                self.authVM.login(email: email, password: password)
            } label: {
                Capsule()
                    .frame(width: 360, height: 40, alignment: .center)
                    .foregroundColor(.backgroundblue)
                    .overlay {
                        Text("Login")
                            .foregroundColor(.white)
                    }
            }
            Text("Forgot Password?")
                .foregroundColor(.blue)
        }
        .padding(.bottom, 4)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
