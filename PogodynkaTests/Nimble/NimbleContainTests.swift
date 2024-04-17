//
//  NimbleContainTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 17/04/2024.
//

import XCTest
import Nimble

final class NimbleContainTests: XCTestCase {

    func test_ContainPrefix() {
        expect("Swift is awesome").to(containPrefix("Swift"))
        expect("Swift is awesome").toNot(containPrefix("Objective-C"))
        expect("Swift is awesome").toNot(containPrefix("wift"))
        expect("Swift is awesome").toNot(containPrefix("swift"))
        expect("Swift_is_awesome").to(containPrefix("S"))
        expect("Swift").to(containPrefix("Swift"))
    }
    
    func test_ContainSuffix() {
        expect("Swift is awesome").to(containSuffix("awesome"))
        expect("Swift is awesome").toNot(containSuffix("modern"))
        expect("Swift is awesome").toNot(containSuffix("awesom"))
        expect("Swift is awesome").toNot(containSuffix("AWESOME"))
        expect("Swift_is_awesome").to(containSuffix("e"))
        expect("Swift").to(containSuffix("Swift"))
    }
}
