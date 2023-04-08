//
//  BlurView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct BlurViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
