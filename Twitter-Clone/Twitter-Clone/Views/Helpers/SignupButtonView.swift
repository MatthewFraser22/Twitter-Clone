//
//  SignupButtonView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

public enum SignupMethod: String {
    case google = "google"
    case apple = "apple"
    case createAccount
}

struct SignupButtonView: View {
    var signupMethod: SignupMethod
    

    var body: some View {
        if signupMethod != .createAccount {
            Button {
                print("Sign in with \(signupMethod.rawValue)")
            } label: {
                HStack(spacing: nil) {
                    Image("\(signupMethod.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("Continue with \(signupMethod.rawValue.capitalized)")
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding()
                }.overlay {
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Color.black, lineWidth: 1)
                        .opacity(0.3)
                        .frame(width: 320, height: 60, alignment: .center)
                    
                }
            }
        } else {
            RoundedRectangle(cornerRadius: 36)
                .foregroundColor(.backgroundblue)
                .frame(width: 320, height: 60, alignment: .center)
                .overlay {
                    Text("Create Account")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding()
                }
        }
    }
}

struct SignupButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignupButtonView(signupMethod: .google)
    }
}
