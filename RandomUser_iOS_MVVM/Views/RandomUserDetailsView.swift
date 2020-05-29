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
    
    var body: some View {
        VStack() {
            WebImage.configure(url: user.picture.large)
            Spacer()
            Text.configure(user.accessibilities)
            Spacer()
            Text.configure(user.expandedLocation)
            Spacer()
        }.navigationBarTitle(Text("\(user.fullName) (\(user.gender))"))
            .background(Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.width,
                       height: UIScreen.height)
                .blur(radius: 30.0, opaque: false))
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
