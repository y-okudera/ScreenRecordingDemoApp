//
//  TopPresenter.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

// MARK: - protocol

protocol TopPresentation: class {
    func viewWillAppear()
    func startTutorial()
}

// MARK: - class

final class TopPresenter {
    
    private weak var view: TopView?
    private let router: TopWireframe

    init(view: TopView, router: TopWireframe) {
        self.view = view
        self.router = router
    }
}

extension TopPresenter: TopPresentation {
    
    func viewWillAppear() {
        AppPreferences.shared.set(value: false, forKey: .startedScreenRecording)
        AppPreferences.shared.set(value: false, forKey: .finishedTutorial)
    }
    
    func startTutorial() {
        let startedScreenRecording = AppPreferences.shared.bool(forKey: .startedScreenRecording)
        if startedScreenRecording {
            print(#function, "アプリ上のボタンで録画を開始している")
            router.showTutorialView()
        } else {
            print(#function, "アプリ上のボタンで録画を開始していない")
            view?.showAlert(title: "確認", message: "「画面録画を開始」ボタンで録画開始後、再度実行してください。\n\n既に画面録画中の場合は、一度録画を終了して、再度お試しください。")
        }
    }
}
