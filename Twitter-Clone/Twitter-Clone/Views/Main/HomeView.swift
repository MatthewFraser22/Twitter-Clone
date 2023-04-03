//
//  HomeView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            ZStack {
                TabView {
                    FeedView()
                        .tabItem {
                            Image("Home")
                        }
                    SearchView()
                        .tabItem {
                            Image("Search")
                        }
                    NotificationsView()
                        .tabItem {
                            Image("Notifications")
                        }
                    MessagesView()
                        .tabItem {
                            Image("Messages")
                        }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
