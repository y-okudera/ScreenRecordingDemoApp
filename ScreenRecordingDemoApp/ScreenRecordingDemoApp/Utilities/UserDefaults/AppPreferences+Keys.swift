//
//  AppPreferences+Keys.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

// MARK: - bool value
extension AppPreferences: BoolDefaults {
    enum BoolKey: String {
        /// 画面録画開始フラグ
        case startedScreenRecording
        /// チュートリアル完了フラグ
        case finishedTutorial
    }
}
