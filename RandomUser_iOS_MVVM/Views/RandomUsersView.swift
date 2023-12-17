//
//  RandomUsersView.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import SwiftUI
import SwiftUIPullToRefresh
import SkeletonUI

/// The content of the first screen.
struct RandomUsersView: View {
    @ObservedObject private var viewModel = RandomUsersViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users, content: row)
            }
            .navigationTitle("Random users")
            .refreshable { await refresh() }
        }
    }
}

extension RandomUsersView {
    /// Function to build the rows on the main screen.
    @ViewBuilder private func row(_ user: User) -> some View {
        /// If the current element is not nilUser, then if contains some real data.
        if user.email != .init() {
            NavigationLink(destination: RandomUserDetailsView(user: user), label: {
                VStack {
                    HStack {
                        ImageServiceNuke
                            .load(url: user.picture.medium)
                            .frame(width: UIScreen.width * 0.15,
                                   height: UIScreen.width * 0.15)
                        Text(user.fullName)
                    }
                    .frame(width: UIScreen.width, alignment: .leading)
                    .background(Color.clear)
                    .padding(.leading, UIScreen.width * 0.15)
                }
            })
        } else {
            /// Else it just dummy object, so it shows a loading indicator, and starts to fetch some more data.
            VStack {
                LottieView(name: "loading")
                    .frame(width: UIScreen.width * 0.15,
                           height: UIScreen.width * 0.15)
            }
            .onAppear {
                run(1.0) {
                    viewModel.getRandomUsers()
                }
            }
            .frame(height: UIScreen.width * 0.20)
        }
    }
}

extension RandomUsersView {
    private func refresh() async {
        await withCheckedContinuation { continuation in
            viewModel.getRandomUsers(refresh: true) {
                continuation.resume(returning: ())
            }
        }
    }
}

#Preview {
    RandomUsersView()
}
