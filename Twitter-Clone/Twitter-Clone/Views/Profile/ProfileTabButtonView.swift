//
//  ProfileTabButtonView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct ProfileTabButtonView: View {
    @Binding var currentTab: ProfileTabButtonOptions
    var title: ProfileTabButtonOptions
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            
        } label: {
            LazyVStack(spacing: 12) {
                Text(title.rawValue)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue)
                        .frame(height: 1.2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 1.2)
                }
            }
        }
        
    }
}
