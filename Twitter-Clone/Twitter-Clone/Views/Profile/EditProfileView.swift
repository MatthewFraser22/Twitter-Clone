//
//  EditProfileView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @State var profileImage: Image?
    @State var imagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State var name = ""
    @State var location = ""
    @State var bio = ""
    @State var website = ""

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                        
                    }

                    Spacer()

                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.black)
                        
                    }
                }
                .padding()

                HStack {
                    Spacer()

                    Text("Edit Profile")
                        .fontWeight(.heavy)

                    Spacer()
                    
                }
            }

            Image("banner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: 180, alignment: .center)
                .cornerRadius(0)

            HStack {
                if profileImage == nil {
                    Button {
                        self.imagePickerPresented.toggle()
                    } label: {
                        KFImage(URL(string: "http://localhost:3000/users/\(1)/avatar"))
                            .resizable()
                            .placeholder {
                                Image("blankpp")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.leading, 12)
                    }
                    .sheet(isPresented: $imagePickerPresented) {
                        loadImage()
                    } content: {
                        ImagePicker(image: $selectedImage)
                    }
                } else if let image = profileImage {
                    VStack {
                        HStack(alignment: .top) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                        }
                        .padding()
                    }
                    .padding(.leading, 12)
                }

                Spacer()
            }
            .padding(.top, -25)
            .padding(.bottom, -10)
            
            VStack {
                Divider()

                HStack {
                    ZStack {
                        HStack {
                            Text("Name")
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        
                        CustomProfileTextField(text: $name, placeholder: "Add your name")
                            .padding(.leading, 90)
                    }
                }.padding(.horizontal)
                
                Divider()

                HStack {
                    ZStack {
                        HStack {
                            Text("Location")
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        
                        CustomProfileTextField(text: $location, placeholder: "Add your location")
                            .padding(.leading, 90)
                    }
                }.padding(.horizontal)
                
                Divider()

                HStack {
                    ZStack(alignment: .topLeading) {
                        HStack {
                            Text("Bio")
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        
                        CustomProfileBioTextField(text: $bio)
                            .padding(.leading, 90)
                            .padding(.top, -6)
                    }
                }.padding(.horizontal)
                
                Divider()

                HStack {
                    ZStack {
                        HStack {
                            Text("website")
                                .foregroundColor(.black)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        
                        CustomProfileTextField(text: $website, placeholder: "Add your website")
                            .padding(.leading, 90)
                    }
                }.padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }

        profileImage = Image(uiImage: selectedImage)
    }
}
