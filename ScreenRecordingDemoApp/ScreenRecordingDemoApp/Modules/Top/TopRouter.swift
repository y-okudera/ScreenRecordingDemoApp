//
//  TopRouter.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

// MARK: - protocol

protocol TopWireframe: class {
    func showTutorialView()
}

// MARK: - class

final class TopRouter {

    weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /// 依存関係の解決をする
    static func assembleModules() -> UIViewController {
        let view: TopViewController = .instantiate()
        let router = TopRouter(viewController: view)
        let presenter = TopPresenter(view: view, router: router)
        
        // ViewにPresenterを設定
        view.presenter = presenter

        view.navigationItem.title = "トップ"
        return view
    }
}

extension TopRouter: TopWireframe {
    
    func showTutorialView() {
        let tutorialView = TutorialRouter.assembleModules()
        viewController?.navigationController?.pushViewController(tutorialView, animated: true)
    }
}
