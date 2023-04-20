//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-06.
//

import SwiftUI

struct MainView: View {
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90

    let user: User

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    VStack {
                        TopBarView(x: $x)
                        HomeView()
                    }
                    .offset(x: x + width)

                    slideMenuView
                }
                .gesture(DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            // translation to the right
                            if value.translation.width > 0 {
                                if x < 0 {
                                    x = -width + value.translation.width
                                }
                            } else {
                                if x != -width {
                                    x = value.translation.width
                                }
                            }
                        }
                    })
                        .onEnded({ value in
                            withAnimation {
                                if -x < width / 2 {
                                    x = 0
                                } else {
                                    x = -width
                                }
                            }
                        })
                )
            }
            .toolbar(.hidden)
            .navigationTitle("")
        }
    }

    private var slideMenuView: some View {
        SlideMenuView()
            .shadow(color: .black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
            .offset(x: x)
            .background(Color.black.opacity(x == 0 ? 0.5 : 0))
            .ignoresSafeArea(.all, edges: .vertical)
            .onTapGesture {
                withAnimation {
                    x = -width
                }
            }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
