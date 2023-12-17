//
//  LottieView.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 06. 04..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieView {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    let name: String
    private let loopMode: LottieLoopMode = .loop
    let animationView = LottieAnimationView()

    final class Coordinator: NSObject {
        var parent: LottieView

        init(_ animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }
}

extension LottieView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        animationView.animation = LottieAnimation.asset(name)
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = loopMode

        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
