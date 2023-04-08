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

    var body: some View {
        if !emailDone {
            VStack {
                VStack {
                    topBarView
                    gettingStartedTextView(text: "To get started first enter your phone, email, or @username")
                    authTextField(placeholderText: "Phone, email, or username", isSecure: false)
                }
                Spacer(minLength: 0)
                advanceToNextScreenButtonView(buttonText: "Next")
            }
        } else {
            VStack {
                VStack {
                    topBarView
                    gettingStartedTextView(text: "Password")
                    authTextField(placeholderText: "Password", isSecure: true)
                }
                Spacer(minLength: 0)
                advanceToNextScreenButtonView(buttonText: "Login")
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

    private func authTextField(placeholderText: String, isSecure: Bool) -> some View {
        CustomAuthTextField(placeholder: placeholderText, isSecureTxtField: isSecure, text: $email)
    }

    private func advanceToNextScreenButtonView(buttonText: String) -> some View {
        VStack {
            Button {
                self.emailDone.toggle()
            } label: {
                Capsule()
                    .frame(width: 360, height: 40, alignment: .center)
                    .foregroundColor(.backgroundblue)
                    .overlay {
                        Text(buttonText)
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
