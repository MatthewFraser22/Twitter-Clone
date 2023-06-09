//
//  HomeView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

fileprivate enum SelectedTabViewIndex: Int {
    case feed = 0
    case search = 1
    case notification = 2
    case messaege = 3
}

struct HomeView: View {
    @State fileprivate var selectedIndex: SelectedTabViewIndex = .feed
    @State var showCreateTweet: Bool = false
    @State var text: String = ""

    var body: some View {
        VStack {
            ZStack {
                tabView
                createTweetButton
            }
            .sheet(isPresented: $showCreateTweet) {
                // OnDismiss
            } content: {
                CreateTweetView(text: text)
            }

        }
    }

    // MARK: - Create Tweet Button

    private var createTweetButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()

                Button(action: {
                    self.showCreateTweet.toggle()
                }, label: {
                    Image("tweet")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                        .background(Color.backgroundblue)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                    
            })
            }
        }
        .padding(.bottom, 75)
        .padding(.trailing, 20)
    }

    // MARK: - TabView Display

    private var tabView: some View {
        TabView {
            FeedView()
                .toolbar(.hidden)
                .onTapGesture {
                    selectedIndex = .feed
                }
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                        .foregroundColor(selectedIndex == .feed ? .backgroundblue : .gray)
                }
                .tag(SelectedTabViewIndex.feed.rawValue)
            SearchView()
                .toolbar(.hidden)
                .onTapGesture {
                    selectedIndex = .search
                }
                .tabItem {
                    Image("Search")
                        .renderingMode(.template)
                        .foregroundColor(selectedIndex == .search ? .backgroundblue : .gray)
                }
                .tag(SelectedTabViewIndex.search.rawValue)
            NotificationsView()
                .toolbar(.hidden)
                .onTapGesture {
                    selectedIndex = .notification
                }
                .tabItem {
                    Image("Notifications")
                        .renderingMode(.template)
                        .foregroundColor(selectedIndex == .notification ? .backgroundblue : .gray)
                }
                .tag(SelectedTabViewIndex.notification.rawValue)
            MessagesView()
                .toolbar(.hidden)
                .onTapGesture {
                    selectedIndex = .messaege
                }
                .tabItem {
                    Image("Messages")
                        .renderingMode(.template)
                        .foregroundColor(selectedIndex == .messaege ? .backgroundblue : .gray)
                }
                .tag(SelectedTabViewIndex.messaege.rawValue)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
