//
//  SearchHistoryStorage.swift
//  Pogodynka
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import Foundation

protocol StorageProtocol {
    func object(forKey keyName: String) -> Any?
    func set(_ value: Any?, forKey keyName: String)
    func remove(forKey keyName: String)
}

class UserDefaultsStorage: StorageProtocol {
    
    private let userDefaults: UserDefaults
        
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func object(forKey keyName: String) -> Any? {
        return userDefaults.object(forKey: keyName)
    }
    
    func set(_ value: Any?, forKey keyName: String) {
        userDefaults.set(value, forKey: keyName)
    }
    
    func remove(forKey keyName: String) {
        userDefaults.removeObject(forKey: keyName)
    }
}

class SearchHistoryStorage {
    private let historyKey = "Pogodynka.Search.HistoryKey"
    private let storage: StorageProtocol
    let maxHistoryCount: Int
    
    init(storage: StorageProtocol, maxCount: Int) {
        self.storage = storage
        self.maxHistoryCount = maxCount
    }
    
    func add(string: String) {
        var history = loadHistory()
        history.insert(string, at: 0)
        
        if history.count > maxHistoryCount {
            history.removeLast()
        }
        
        storage.set(history, forKey: historyKey)
    }
    
    func loadLast() -> String? {
        return loadHistory().first
    }
    
    func loadHistory() -> [String] {
        let history = storage.object(forKey: historyKey) as? [String]
        return history ?? []
    }
}
