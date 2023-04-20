//
//  RegisterView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            topBarView
            createYourAccountTitle
            userFields
            Spacer(minLength: 0)
            nextButtonView
        }
    }

    private var topBarView: some View {
        ZStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal)

            Image("Twitter")
                .resizable()
                .scaledToFill()
                .padding(.trailing)
                .frame(width: 20, height: 20)
        }
    }

    private var createYourAccountTitle: some View {
        Text("Create your account")
            .font(.title)
            .bold()
            .padding(.top, 35)
    }

    private var userFields: some View {
        VStack(alignment: .leading, spacing: nil) {
            CustomAuthTextField(placeholder: "Name", isSecureTxtField: false, text: $name)
            CustomAuthTextField(placeholder: "Phone number or email", isSecureTxtField: false, text: $email)
            CustomAuthTextField(placeholder: "Password", isSecureTxtField: true, text: $password)
        }
        
    }

    private var nextButtonView: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)

            HStack {
                Spacer()

                Button {
                    self.viewModel.register(name: name, username: name, email: email, password: password)
                } label: {
                    Capsule()
                        .frame(width: 60, height: 30, alignment: .center)
                        .foregroundColor(.backgroundblue)
                        .overlay {
                            Text("Next")
                                .foregroundColor(.white)
                        }
                }

            }.padding(.trailing, 24)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
