//
//  AppDelegate.swift
//  Daily Weather
//
//  Created by Quasar on 13.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

func application(
    _ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication, configurationForConnecting
        connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
