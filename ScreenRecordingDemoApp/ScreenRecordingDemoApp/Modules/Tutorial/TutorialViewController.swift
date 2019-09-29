//
//  TutorialViewController.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

// MARK: - protocol

protocol TutorialView: class {
    func updateScreenRecordingStatusLabel()
    func showAlert(title: String?, message: String)
}

// MARK: - class

/// チュートリアル画面
final class TutorialViewController: UIViewController {
    
    @IBOutlet private weak var screenRecordingStatusLabel: UILabel!
    
    var observers = [NSObjectProtocol]()
    var presenter: TutorialPresentation!
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observers.append(self.addObserver())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver(observers: &self.observers)
    }
    
    // MARK: - IBActions
    
    @IBAction private func tappedTutorialFinishButton(_ sender: UIButton) {        
        presenter.finishTutorial()
    }
}

extension TutorialViewController: TutorialView {
    func updateScreenRecordingStatusLabel() {
        screenRecordingStatusLabel.text = "画面録画停止"
    }
    
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            .init(title: "OK", style: .default)
        )
        self.present(alert, animated: true, completion: nil)
    }
}

extension TutorialViewController: ScreenCaptureObservable {}
