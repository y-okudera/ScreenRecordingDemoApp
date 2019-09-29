//
//  UIViewController+Instantiate.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

extension UIViewController {

    /// StoryboardからViewControllerのインスタンスを生成する
    ///
    /// - Precondition: ViewControllerクラスの名称とStoryboardのファイル名、Storyboard IDが同じである前提
    ///
    /// - Note: ex) LoginViewController.swift, LoginViewController.storyboard, Storyboard ID: LoginViewController
    class func instantiate<T: UIViewController>() -> T {
        let viewControllerName = String(describing: T.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: Bundle(for: T.self))
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? T else {
            fatalError("Failed to instantiate \(viewControllerName).")
        }
        return viewController
    }
}
