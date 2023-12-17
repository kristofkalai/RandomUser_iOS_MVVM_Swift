//
//  RandomUserDetailsView.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import DisplayLink
import SkeletonUI

/// The second screen.
struct RandomUserDetailsView: View {
    let user: User
    private let animationDuration = 3.5
    @State private var accessibilitiesString = ""
    @State private var expandedLocationString = ""
    @State private var animationStartDate = Date()
    @State private var url = ""

    var body: some View {
        VStack() {
            ImageServiceNuke
                .load(url: url)
                .skeleton(with: url.isEmpty, transition: (.opacity, .easeInOut))
                .onAppear {
                    run(2) {
                        url = user.picture.large
                    }
                }
                .clipShape(Circle())
                .frame(width: UIScreen.width * 0.8,
                       height: UIScreen.width * 0.8)
            Spacer()
            Text.configure(accessibilitiesString).onFrame { _ in
                onFrameRefresh(text: &accessibilitiesString, fullString: user.accessibilities)
            }
            Spacer()
            Text.configure(expandedLocationString).onFrame { _ in
                onFrameRefresh(text: &expandedLocationString, fullString: user.expandedLocation)
            }
            Spacer()
        }.navigationBarTitle(Text("\(user.fullName) (\(user.gender))"))
            .background(Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.width,
                       height: UIScreen.height)
                    .blur(radius: 30.0, opaque: false))
            .onAppear {
                animationStartDate = Date()
            }
    }

    private func onFrameRefresh(text: inout String, fullString: String) {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        if elapsedTime > animationDuration {
            text = fullString
        } else {
            let percentage = elapsedTime / animationDuration
            let index = fullString.index(fullString.startIndex, offsetBy: Int(percentage * Double(fullString.count)))
            text = String(fullString[..<index])
        }
    }
}

/// Text extension for the less code duplicate.
private extension Text {
    static func configure(_ text: String) -> some View {
        Text(text)
            .frame(width: UIScreen.width * 0.8,
                   alignment: .leading)
            .font(.caption)
            .foregroundColor(.white)
    }
}

#Preview {
    RandomUserDetailsView(user: User())
}
