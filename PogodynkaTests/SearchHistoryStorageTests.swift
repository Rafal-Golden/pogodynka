//
//  SearchHistoryStorage.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class SearchHistoryStorageTests: XCTestCase {
    
    var sut: SearchHistoryStorage!
    var storageMock: UserDefaultsStorageMock!

    override func setUp() {
        super.setUp()
        storageMock = UserDefaultsStorageMock()
        sut = SearchHistoryStorage(storage: storageMock, maxCount: 3)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        storageMock = nil
    }
 
    func test_initStateLoadLast_isEmpty() {
        let last = self.sut.loadLast()
        
        expect(last).to(beNil())
        expect(self.storageMock.objectForKeyCalled).to(beTrue())
    }
    
    func test_initStateLoadHistory_isEmpty() {
        let history = self.sut.loadHistory()
        
        expect(history).to(beEmpty())
        expect(self.storageMock.objectForKeyCalled).to(beTrue())
    }
    
    func test_addRecord_returnsLast() {
        let first = "First search"
        sut.add(string: first)
        let second = "Second search"
        
        sut.add(string: second)
        
        expect(self.storageMock.setValueCalled).to(beTrue())
        expect(self.sut.loadLast()).to(equal(second))
        
        let loadedHistory = self.sut.loadHistory()
        expect(loadedHistory.last).to(equal(first))
    }
    
    func test_addRecord_RemovesLastElement() {
        let max = sut.maxHistoryCount
        for i in 0..<max {
            sut.add(string: "history_\(i)")
        }
        let expectedFirstRecord = "history_1"

        let lastRecord = "history_\(max)"
        sut.add(string: lastRecord)

        expect(self.sut.loadLast()).to(equal(lastRecord))
        expect(self.sut.loadHistory().last).to(equal(expectedFirstRecord))
    }
}

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
