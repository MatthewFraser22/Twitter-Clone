//
//  WelcomeView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                topBarView
                Spacer(minLength: 0)
                welcomeText
                Spacer(minLength: 0)
                signUpButtonsView
                bottomView
            }
            .toolbar(.hidden)
            .navigationTitle("")
        }
    }

    private var topBarView: some View {
        HStack {
            Spacer(minLength: 0)

            Image("Twitter")
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)

            Spacer(minLength: 0)
        }
    }

    private var welcomeText: some View {
        Text("See What's happening in the world right now.")
            .font(.system(size: 30, weight: .heavy, design: .default))
            .frame(width: getRect().width  * 0.9, alignment: .center)
    }

    private var signUpButtonsView: some View {
        VStack(alignment: .center, spacing: 10) {
            SignupButtonView(signupMethod: .google)
            SignupButtonView(signupMethod: .apple)

            HStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(width: getRect().width * 0.35, height: 1)

                Text("Or")
                    .foregroundColor(.gray)

                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(width: getRect().width * 0.35, height: 1)
            }

            SignupButtonView(signupMethod: .createAccount)
        }
    }
    
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("By signing up, you agree to our ") +
            Text("Terms")
                .foregroundColor(.backgroundblue) +
            Text(", ") +
            Text("Privacy Policy")
                .foregroundColor(.backgroundblue) +
            Text(", Cookie Use.")
                .foregroundColor(.backgroundblue)

            HStack(spacing: 2) {
                Text("Have an account already? ")
                Text("Sign in")
                    .foregroundColor(.backgroundblue)
            }
        }
        .padding([.leading, .trailing], 10)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
