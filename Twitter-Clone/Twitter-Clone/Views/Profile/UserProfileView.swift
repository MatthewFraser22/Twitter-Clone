//
//  UserProfileView.swift
//  TwitterClone
//
//  Created by Matthew Fraser on 2022-12-14.
//

import SwiftUI

struct UserProfileView: View {
    @State var offset: CGFloat = 0.0
    @State var titleOffset: CGFloat = 0.0
    @State var tabBarOffset: CGFloat = 0.0
    @State var currentTab: ProfileTabButtonOptions = .tweets

    @Namespace var animation

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                GeometryReader { (geometryProxy) -> AnyView in
                    
                    let minY = geometryProxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return AnyView(
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: getRect().width,
                                    height: minY > 0 ? 180 + minY : 180,
                                    alignment: .center
                                )
                                .cornerRadius(0)
                            
                            BlurViewRepresentable()
                                .opacity(blurViewOpacity())

                            nameDetailsView
                        }
                            .clipped()
                            .frame(height: minY > 0 ? 180 + minY : nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )

                }
                .frame(height: 180)
                .zIndex(1)

                profileBioView

            }
        }
        .ignoresSafeArea(.all)
    }

    private var nameDetailsView: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("Matt")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("150 Tweets")
                .foregroundColor(.white)
        }
        .offset(y: 120) // Push the text down by offseting 120 px in y direction
        .offset(y: titleOffset > 100 ? 0 : -getTitleOffset())
        .opacity(titleOffset < 100 ? 1 : 0)
    }

    private var profileBioView: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("blankpp")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .offset(y: offset < 0 ? getOffset() - 20 : -20)
                    .scaleEffect(getScale())

                Spacer(minLength: 0)

                Button {
                    
                } label: {
                    Text("Edit Profile")
                        .foregroundColor(.blue)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(
                            Capsule()
                                .stroke(Color.blue, lineWidth: 1.5)
                        )
                }

            }
            .padding(.top, -25) // get overlay on ZStack
            .padding(.bottom, -10)

            profileBio
            profileTabButtons
            feedView
        }
        .padding()
        .zIndex(-offset > 80 ? 0 : 1)
    }
    
    private var profileBio: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Matt")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("@matt_fraser")
                .foregroundColor(.gray)

            Text("This is my profile bio")
            
            HStack(spacing: 5) {
                Text("1")
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                
                Text("Followers")
                    .foregroundColor(.gray)
                
                Text("5")
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding(.leading, 10)
                
                Text("Following")
                    .foregroundColor(.gray)
            }
        }
        .overlay(
            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                
                DispatchQueue.main.async {
                    self.titleOffset = minY
                }
                
                return Color.clear
            }.frame(width: 0, height: 0)
            , alignment: .top
        )
        .padding()
    }

    private var profileTabButtons: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(ProfileTabButtonOptions.allCases, id: \.rawValue) { tabButton in
                        ProfileTabButtonView(currentTab: $currentTab, title: tabButton, animation: animation)
                    }
                }
            }
        }
        .padding(.top, 30)
        .background(Color.white)
        .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
        .overlay(
            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                
                DispatchQueue.main.async {
                    self.tabBarOffset = minY
                }
                
                return Color.clear
            }.frame(width: 0, height: 0)
            , alignment: .top
        ).zIndex(1)
    }

    private var feedView: some View {
        VStack(spacing: 18) {
            TweetCellView(tweet: "HI", tweetImage: "post")
            Divider()
            ForEach(0..<20, id: \.self) { _ in
                TweetCellView(tweet: "sdsdfrgerger")
                Divider()
            }
        }
        .padding(.top)
        .zIndex(0)
    }

    //
    // MARK: Helpers
    //

    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150

        return Double(-offset > 80 ? progress : 0)
    }

    func getTitleOffset() -> CGFloat {
        let progeress = 20 / titleOffset
        let offset = 60 * (progeress > 0 && progeress <= 1 ? progeress : 1)

        return offset
    }

    func getOffset() -> CGFloat {
        let progress = (-offset/80) * 20
        return progress <= 20 ? progress : 20
    }

    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)

        return scale < 1 ? scale : 1
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

public enum ProfileTabButtonOptions: String, CaseIterable {
    case tweets = "Tweets"
    case tweetsAndLikes = "Tweets & Likes"
    case media = "Media"
    case likes = "Likes"
}
