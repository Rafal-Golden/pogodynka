//
//  UserDefaultsStorageMock.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 11/03/2024.
//

import Foundation
@testable import Pogodynka

class UserDefaultsStorageMock: StorageProtocol {
    var storedDictionary: [String: Any] = [:]
    var objectForKeyCalled = false
    var setValueCalled = false
    var removeForKeyCalled = false
    
    func object(forKey keyName: String) -> Any? {
        objectForKeyCalled = true
        return storedDictionary[keyName]
    }
    
    func set(_ value: Any?, forKey keyName: String) {
        setValueCalled = true
        storedDictionary[keyName] = value
    }
    
    func remove(forKey keyName: String) {
        removeForKeyCalled = true
        storedDictionary[keyName] = nil
    }
}
