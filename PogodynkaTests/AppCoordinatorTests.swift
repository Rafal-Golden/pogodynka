//
//  PogodynkaTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 05/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class AppCoordinatorTests: XCTestCase {
    
    var sut: AppCoordinator!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = AppCoordinator(window: window)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        window = nil
    }
    
    // MARK: - TESTS -

    func test_afterInit_containsViewController() {
        sut.start()
        expect(self.sut.viewControllersCount).to(equal(1))
        expect(self.sut.children).toNot(beEmpty())
    }
}
