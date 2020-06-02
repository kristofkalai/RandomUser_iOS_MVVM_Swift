//
//  ActivityIndicator.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI

/// Custom UIActivityIndicator implementation in SwiftUI.
struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    private let style: UIActivityIndicatorView.Style = .medium
    
    init(isAnimating: Binding<Bool> = .constant(true)) {
        _isAnimating = isAnimating
    }
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    
    static var previews: some View {
        return ActivityIndicator()
    }
}
