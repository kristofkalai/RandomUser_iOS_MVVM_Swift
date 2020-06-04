//
//  RandomUsersView.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftUIPullToRefresh
import SkeletonUI

/// The content of the first screen.
struct RandomUsersView: View {
    
    @ObservedObject var viewModel = RandomUsersViewModel()
    
    @ViewBuilder
    var body: some View {
        
        RefreshableNavigationView(title: "Random users",
                                  showRefreshView: $viewModel.showRefreshView,
                                  displayMode: .inline,
                                  action: {
                                    self.viewModel.getRandomUsers(refresh: true)
        }){
            ForEach(self.viewModel.users) { user in
                self.buildRow(user)
            }
        }
    }
    
    /// Function to build the rows on the main screen.
    func buildRow(_ user: User) -> AnyView {
        
        /// If the current element is not nilUser, then if contains some real data.
        if user.email != "" {
            return AnyView(
                NavigationLink(destination: RandomUserDetailsView(user: user), label: {
                    VStack {
                        HStack {
                            WebImage.configure(url: user.picture.medium,
                                               widthMultiplier: 0.2)
                            Text(user.fullName)
                        }.frame(width: UIScreen.width,
                                alignment: .leading)
                            .background(Color.clear)
                        Divider()
                    }
                })
            )
        /// Else it just dummy object, so it shows a loading indicator, and starts to fetch some more data.
        } else {
            return AnyView(
                VStack {
                    LottieView(name: "loading")
                        .frame(width: UIScreen.width * 0.15,
                               height: UIScreen.width * 0.15)
                    Divider()
                }.onAppear(perform: {
                    run(1.0) {
                        self.viewModel.getRandomUsers()
                    }
                })
            )
        }
    }
}

struct RandomUsersView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUsersView()
    }
}
