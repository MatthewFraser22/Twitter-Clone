//
//  SlideMenuView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-06.
//

import SwiftUI

fileprivate enum MenuOptions: String, CaseIterable {
    case profile = "Profile"
    case lists = "Lists"
    case topics = "Topics"
    case bookmarks = "Bookmarks"
    case moments = "Moments"
}

struct SlideMenuView: View {
    @State var showMenu: Bool = false
    var edges = 0
    @State var width = UIScreen.main.bounds.width
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        GeometryReader { geometryProxy in
            VStack {
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        NavigationLink(destination: UserProfileView(user: viewModel.currentUser)) {
                            Image("blankpp")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        }

                        usernameAndFollowerCount
                        coreMenuItemsAndHelp
                        createOrAddNewAccount

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .padding(.top, geometryProxy.safeAreaInsets.top == 0 ? 15 : geometryProxy.safeAreaInsets.top)
                    .padding(.bottom, geometryProxy.safeAreaInsets.bottom == 0 ? 15 : geometryProxy.safeAreaInsets.bottom)
                    .frame(width: width-90)
                    .background(.white)
                    .ignoresSafeArea(.all, edges: .vertical)
                }

            }
        }
    }

    private var usernameAndFollowerCount: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                NavigationLink(destination: UserProfileView(user: viewModel.currentUser)) {
                    Text(viewModel.currentUser?.username ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }

                Text("@\(viewModel.currentUser?.username ?? "")")
                    .foregroundColor(.gray)

                HStack(spacing: 20) {
                    FollowView(count: 12, title: "Following")
                    FollowView(count: 20, title: "Followers")
                }.padding(.top, 10)

                Divider()
                    .padding(.top, 10)
            }

            Spacer(minLength: 0)

            Button {
                withAnimation {
                    self.showMenu.toggle()
                }
            } label: {
                
                Image(systemName: self.showMenu == true ? "chevron.up" : "chevron.down")
                    .foregroundColor(.backgroundblue)
            }

        }
    }

    private var coreMenuItemsAndHelp: some View {
        VStack(alignment: .leading) {
            ForEach(MenuOptions.allCases, id: \.self) { menuOption in
                MenuButtonView(imageName: menuOption.rawValue)
            }
            
            Divider()
                .padding(.top)

            Button {
                
            } label: {
                MenuButtonView(imageName: "Twitter Ads")
            }

            Divider()

            Button {
                
            } label: {
                Text("Settings and Privacy")
                    .foregroundColor(.black)
            }.padding(.top, 20)
            
            Button {
                
            } label: {
                Text("Help center")
                    .foregroundColor(.black)
            }

            Spacer(minLength: 0)

            Divider()
                .padding(.bottom)

            HStack {
                Button {
                    
                } label: {
                    Image("help")
                        .renderingMode(.template) // for changing the color
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.backgroundblue)
                }

                Spacer(minLength: 0)
                
                Image("barcode")
                    .renderingMode(.template) // for changing the color
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.backgroundblue)
            }
        }
        .opacity(self.showMenu == true ? 1 : 0)
        .frame(height: showMenu ? nil : 0)
    }

    private var createOrAddNewAccount: some View {
        VStack(alignment: .leading) {
            Button {
                
            } label: {
                Text("Create new account")
                    .foregroundColor(.backgroundblue)
            }

            Button {
                
            } label: {
                Text("Add an existing account")
                    .foregroundColor(.backgroundblue)
            }

        }
        .opacity(showMenu ? 0 : 1)
        .frame(height: showMenu ? 0 : nil)
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(viewModel: AuthViewModel.shared)
    }
}
