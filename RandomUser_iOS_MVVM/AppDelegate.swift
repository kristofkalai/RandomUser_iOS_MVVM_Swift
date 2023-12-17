//
//  AppDelegate.swift
//  RandomUser_iOS_MVVM
//
//  Created by Kálai Kristóf on 2020. 05. 29..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import UIKit
import Swinject
import SwiftUI

@main
final class AppDelegate: UIResponder {
    var window: UIWindow?

    static let container: Container = {
        let container = Container()
        container.register(ApiServiceProtocol.self) { _ in ApiServiceAlamofire() }
        return container
    }()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.topItem?.backBarButtonItem = UIBarButtonItem(title: .init(), style: .plain, target: nil, action: nil)
        navigationBarAppearace.barTintColor = .clear

        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear

        self.window = getWindow()

        return true
    }
}

extension AppDelegate {
    private func getWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: RandomUsersView())
        window.rootViewController?.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        return window
    }
}
