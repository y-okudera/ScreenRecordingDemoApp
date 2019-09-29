//
//  TopViewController.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

// MARK: - protocol

protocol TopView: class {
    func showAlert(title: String?, message: String)
}

// MARK: - class

/// トップ画面
final class TopViewController: UIViewController {
    
    var observers = [NSObjectProtocol]()
    var presenter: TopPresentation!
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.view.viewWithTag(SystemBroadcastPickerViewBuilder.viewTag) == nil {
            SystemBroadcastPickerViewBuilder.setup(superView: self.view)
        }
        
        presenter.viewWillAppear()
        self.reloadView()
        
        let observer = self.addObserver(forCapturedDidChange: { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.reloadView()
        }) { [weak self] _ in
            guard let weakSelf = self else {
                return
            }
            weakSelf.reloadView()
        }
        self.observers.append(observer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver(observers: &self.observers)
    }
    
    // MARK: - IBActions
    
    /// チュートリアル開始ボタンをタップ
    @IBAction private func tappedTutorialStartButton(_ sender: UIButton) {
        presenter.startTutorial()
    }
}

extension TopViewController {
    /// ビューを更新する
    private func reloadView() {
        guard let broadCastPicker = SystemBroadcastPickerViewBuilder.broadCastPicker else {
            return
        }
        SystemBroadcastPickerViewBuilder.layout(broadCastPickerView: broadCastPicker, superView: self.view)
    }
}

extension TopViewController: TopView {
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            .init(title: "OK", style: .default)
        )
        self.present(alert, animated: true, completion: nil)
    }
}

extension TopViewController: ScreenCaptureObservable {}
