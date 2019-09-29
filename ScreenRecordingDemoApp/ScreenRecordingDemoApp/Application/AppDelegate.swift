//
//  AppDelegate.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        firstView(viewController: TopRouter.assembleModules(), includeNavigationController: true)
        return true
    }
}

extension AppDelegate {
    
    /// アプリ起動後、最初に表示する画面を設定する
    ///
    /// - Parameters:
    ///   - viewController: 最初に表示する画面のViewController
    ///   - includeNavigationController: NavigationControllerを含めるかどうか
    func firstView(viewController: UIViewController, includeNavigationController: Bool = false) {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if includeNavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.rootViewController = navigationController
        } else {
            window?.rootViewController = viewController
        }
        window?.makeKeyAndVisible()
    }
}

@available(iOS 13, *)
extension AppDelegate {
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
