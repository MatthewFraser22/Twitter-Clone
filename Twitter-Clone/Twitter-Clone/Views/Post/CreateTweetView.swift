//
//  CreateTweetView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct CreateTweetView: View {
    @State var text: String = ""
    @State var imagePickerPresented: Bool = false
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    @ObservedObject var vm = TweetViewModel()
    @Environment(\.presentationMode) var isPresented

    var body: some View {
        VStack {
            topBar
            MultilineTextFeildRepresentable(text: $text)
            selectImage
        }.padding()
    }

    private var topBar: some View {
        HStack {
            Button {
                self.isPresented.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
            }
    
            Spacer()

            Button {
                if !text.isEmpty {
                    self.vm.uploadTweet(text: text, image: selectedImage)
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

    private var selectImage: some View {
        VStack {
            if postImage == nil {
                Button {
                    self.imagePickerPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .padding(.top)
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $imagePickerPresented, onDismiss: {
                    loadImage()
                }) {
                    ImagePicker(image: $selectedImage)
                }
            } else if let image = postImage {
                VStack {
                    HStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .cornerRadius(16)
                            .clipped()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CreateTweetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTweetView()
    }
}

extension CreateTweetView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }

        postImage = Image(uiImage: selectedImage)
    }
}
