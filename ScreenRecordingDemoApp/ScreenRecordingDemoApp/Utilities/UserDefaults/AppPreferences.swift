//
//  AppPreferences.swift
//  ScreenRecordingDemoApp
//
//  Created by Yuki Okudera on 2019/09/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

// MARK: - AppPreferences class
final class AppPreferences {
    static let shared = AppPreferences()
    fileprivate static let ud = UserDefaults.standard
    private init() {}
}

// MARK: - Bool
protocol BoolDefaults: KeyNamespaceable {
    associatedtype BoolKey: RawRepresentable
}

extension BoolDefaults where BoolKey.RawValue == String {
    
    func set(value: Bool, forKey key: BoolKey) {
        AppPreferences.ud.set(value, forKey: namespaced(key))
    }
    
    @discardableResult
    func bool(forKey key: BoolKey) -> Bool {
        return AppPreferences.ud.bool(forKey: namespaced(key))
    }
    
    func removeObject(forKey key: BoolKey) {
        AppPreferences.ud.removeObject(forKey: namespaced(key))
    }
}
