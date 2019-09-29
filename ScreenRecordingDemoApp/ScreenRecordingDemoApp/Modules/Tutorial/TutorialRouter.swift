//
//  TutorialRouter.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//


import UIKit

// MARK: - protocol

protocol TutorialWireframe: class {
    
}

// MARK: - class

final class TutorialRouter {

    weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /// 依存関係の解決をする
    static func assembleModules() -> UIViewController {
        let view: TutorialViewController = .instantiate()
        let router = TutorialRouter(viewController: view)
        let presenter = TutorialPresenter(view: view, router: router)
        
        // ViewにPresenterを設定
        view.presenter = presenter

        view.navigationItem.title = "チュートリアル"
        return view
    }
}

extension TutorialRouter: TutorialWireframe {
    
}
