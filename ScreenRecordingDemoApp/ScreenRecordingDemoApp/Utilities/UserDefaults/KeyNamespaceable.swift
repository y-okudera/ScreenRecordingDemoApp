//
//  KeyNamespaceable.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

protocol KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(String(describing: type(of: key))).\(key.rawValue)"
    }
}
