//
//  TutorialPresenter.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//


import Foundation

// MARK: - protocol

protocol TutorialPresentation: class {
    func finishTutorial()
}

// MARK: - class

final class TutorialPresenter {
    
    private weak var view: TutorialView?
    private let router: TutorialWireframe

    init(view: TutorialView, router: TutorialWireframe) {
        self.view = view
        self.router = router
    }
}

extension TutorialPresenter: TutorialPresentation {
    func finishTutorial() {
        AppPreferences.shared.set(value: true, forKey: .finishedTutorial)
        view?.updateScreenRecordingStatusLabel()
        view?.showAlert(title: "チュートリアル完了", message: "画面録画を終了してください。")
    }
}
