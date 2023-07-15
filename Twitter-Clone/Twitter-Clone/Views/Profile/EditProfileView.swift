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
    @State var name: String
    @State var location: String
    @State var bio: String
    @State var website: String

	@Environment(\.presentationMode) var mode
	@ObservedObject var viewModel: EditProfileViewModel
    @Binding var user: User

    init(user: Binding<User>) {
        self._user = user
		self.viewModel = EditProfileViewModel(user: self._user.wrappedValue) // ???
        self._name = State(initialValue: self._user.name.wrappedValue ?? "")
        self._location = State(initialValue: self._user.location.wrappedValue ?? "")
        self._bio = State(initialValue: self._user.bio.wrappedValue ?? "")
        self._website = State(initialValue: self._user.website.wrappedValue ?? "")
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
						self.mode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                        
                    }

                    Spacer()

                    Button {
						self.viewModel.save(name: name, bio: bio, website: website, location: location)
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
            .onAppear {
                KingfisherManager.shared.cache.clearCache()
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
		.onReceive(viewModel.$uploadComplete) { complete in
			if complete {
				self.mode.wrappedValue.dismiss()
				
				self.user.name = viewModel.user.name
				self.user.website = viewModel.user.website
				self.user.location = viewModel.user.location
				self.user.bio = viewModel.user.bio
			}
		}
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }

        profileImage = Image(uiImage: selectedImage)
    }
}
