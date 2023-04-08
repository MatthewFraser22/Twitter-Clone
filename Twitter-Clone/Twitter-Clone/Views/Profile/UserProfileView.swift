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

                            BlurViewRepresentable()
                                .opacity(blurViewOpacity())

                            nameDetailsView
                        }
                            .clipped()
                            .frame(height: minY > 0 ? 180 + minY : nil)
                            .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                    )
                    
                }

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

public enum ProfileTabButtonOptions: String {
    case tweets = "Tweets"
    case tweetsAndLikes = "Tweets & Likes"
    case media = "Media"
    case likes = "Likes"
}
