//
//  MainView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-06.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TopBarView()
            HomeView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
