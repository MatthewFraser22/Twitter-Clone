//
//  ProfileViewModel.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
