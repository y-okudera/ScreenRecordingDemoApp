//
//  SystemBroadcastPickerViewBuilder.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import ReplayKit

struct SystemBroadcastPickerViewBuilder {
    
    static var broadCastPicker: RPSystemBroadcastPickerView?
    
    static var viewTag: Int {
        return 987654321
    }
    
    private static var broadCastPickerHeight: CGFloat {
        return CGFloat(44.0)
    }
    
    private static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    static func setup(superView: UIView, tag: Int = viewTag) {
        
        let broadCastPickerFrame = CGRect(x: 0,
                                          y: screenSize.height - broadCastPickerHeight,
                                          width: screenSize.width,
                                          height: broadCastPickerHeight)
        broadCastPicker = RPSystemBroadcastPickerView(frame: broadCastPickerFrame)
        broadCastPicker?.preferredExtension = Bundle.main.bundleIdentifier!
        broadCastPicker?.backgroundColor = .red
        broadCastPicker?.showsMicrophoneButton = false
        broadCastPicker?.tag = tag
        
        guard let broadCastPickerView = broadCastPicker else {
            return
        }
        
        // Add subview
        superView.addSubview(broadCastPickerView)
        layout(broadCastPickerView: broadCastPickerView, superView: superView)
    }
    
    /// RPSystemBroadcastPickerViewのボタンのレイアウトを定義
    static func layout(broadCastPickerView: RPSystemBroadcastPickerView, superView: UIView) {
        
        let isCaptured = UIScreen.main.isCaptured
        let buttonTitle = isCaptured ? "画面録画を終了" : "画面録画を開始"
        broadCastPickerView.backgroundColor = isCaptured ? .blue : .red
        
        broadCastPickerView.subviews.forEach {
            if let button = $0 as? UIButton {
                button.setImage(nil, for: .normal)
                button.setTitle(buttonTitle, for: .normal)
            }
        }
        
        // Set autolayout
        broadCastPickerView.translatesAutoresizingMaskIntoConstraints = false
        broadCastPickerView.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        broadCastPickerView.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        broadCastPickerView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        broadCastPickerView.heightAnchor.constraint(equalToConstant: broadCastPickerHeight).isActive = true
    }
}
