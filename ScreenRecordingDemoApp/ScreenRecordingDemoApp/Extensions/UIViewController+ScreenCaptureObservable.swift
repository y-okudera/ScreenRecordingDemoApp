//
//  UIViewController+ScreenCaptureObservable.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

protocol ScreenCaptureObservable {
    
    var observers: [NSObjectProtocol] {get}
    /// 画面録画の変更監視を開始する
    func addObserver(forCapturedDidChange startCapturingBlock: ((Notification) -> Void)?,
                     stopCapturingBlock: ((Notification) -> Void)?) -> NSObjectProtocol
    
    /// Observerを削除する
    func removeObserver(observers: inout [NSObjectProtocol])
    
    /// 画面録画エラーアラート
    func showScreenCaptureErrorAlert()
}

extension ScreenCaptureObservable where Self: UIViewController {
    func addObserver(forCapturedDidChange startCapturingBlock: ((Notification) -> Void)? = nil,
                     stopCapturingBlock: ((Notification) -> Void)? = nil) -> NSObjectProtocol {
        
        let observer = NotificationCenter
            .default
            .addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { [weak self] notification in
                
                if UIScreen.main.isCaptured {
                    print("録画を始めた")                    
                    AppPreferences.shared.set(value: true, forKey: .startedScreenRecording)
                    startCapturingBlock?(notification)
                    return
                }
                
                print("録画を停止した")
                AppPreferences.shared.set(value: false, forKey: .startedScreenRecording)
                
                
                if let block = stopCapturingBlock {
                    block(notification)
                } else {
                    // チュートリアルが完了しているかチェック
                    let finishedTutorial = AppPreferences.shared.bool(forKey: .finishedTutorial)
                    if finishedTutorial {
                        return
                    }
                    self?.showScreenCaptureErrorAlert()
                }
        }
        return observer
    }
    
    func removeObserver(observers: inout [NSObjectProtocol]) {
        NotificationCenter.default.removeObserver(self)
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll()
    }
    
    func showScreenCaptureErrorAlert() {
        let message = "チュートリアル実行中に\n画面録画が停止されました。\nトップに戻ります。"
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
