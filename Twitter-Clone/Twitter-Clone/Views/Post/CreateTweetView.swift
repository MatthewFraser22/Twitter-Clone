//
//  CreateTweetView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct CreateTweetView: View {
    @State var text: String = ""
    @ObservedObject var vm = TweetViewModel()
    @Environment(\.presentationMode) var isPresented

    var body: some View {
        VStack {
            topBar
            MultilineTextFeildRepresentable(text: $text)
        }.padding()
    }

    private var topBar: some View {
        HStack {
            Button {
                
            } label: {
                Text("Cancel")
            }
    
            Spacer()
            
            Button {
                if !text.isEmpty {
                    self.vm.uploadTweet(text: text)
                }

                self.isPresented.wrappedValue.dismiss()
            } label: {
                Text("Tweet")
                    .padding()
            }
            .background(Color.backgroundblue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct CreateTweetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTweetView()
    }
}
