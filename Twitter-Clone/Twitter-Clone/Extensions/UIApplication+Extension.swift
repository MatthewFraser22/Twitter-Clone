//
//  UIApplication+Extension.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-04.
//

import Foundation
import UIKit

extension UIApplication {
    func resignKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
