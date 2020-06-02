//
//  RandomUserDetailsView.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

/// The second screen.
struct RandomUserDetailsView: View {
    
    var user: User
    @State private var accessibilitiesString = ""
    @State private var expandedLocationString = ""
    
    private let animationDuration = 3.5
    @State var animationStartDate = Date()
    
    var body: some View {
        return VStack() {
            WebImage.configure(url: user.picture.large)
            Spacer()
            Text.configure(accessibilitiesString).onFrame { frame in
                self.onFrameRefresh(text: &self.accessibilitiesString, fullString: self.user.accessibilities)
            }
            Spacer()
            Text.configure(expandedLocationString).onFrame { frame in
                self.onFrameRefresh(text: &self.expandedLocationString, fullString: self.user.expandedLocation)
            }
            Spacer()
        }.navigationBarTitle(Text("\(user.fullName) (\(user.gender))"))
            .background(Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.width,
                       height: UIScreen.height)
                .blur(radius: 30.0, opaque: false)).onAppear {
                    self.animationStartDate = Date()
        }
    }
    
    private func onFrameRefresh(text: inout String, fullString: String) {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(self.animationStartDate)
        if elapsedTime > self.animationDuration {
            text = fullString
        } else {
            let percentage = elapsedTime / self.animationDuration
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

struct RandomUserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUserDetailsView(user: User.nilUser())
    }
}
