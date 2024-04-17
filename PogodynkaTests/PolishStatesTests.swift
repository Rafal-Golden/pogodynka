//
//  PolishStatesTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 17/04/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class PolishStatesTests: XCTestCase {
    
    var expectedPrefix: String! = "Województwo "

    override func setUp() {
        super.setUp()
        
        expectedPrefix = "Województwo "
    }

    override func tearDown() {
        super.tearDown()
        
        expectedPrefix = nil
    }

    func test_TranslateState_returns_polishValidName() throws {
        let state = "Lower Silesian Voivodeship"
        let expectedSuffix = "dolnośląskie"
        
        let translatedState = PolishStates.translate(state: state)
        
        expect(translatedState).to(containPrefix(expectedPrefix))
        expect(translatedState).to(containSuffix(expectedSuffix))
        expect(translatedState).to(contain(" "))
    }
    
    func test_TranslateShortState_returns_polishValidName() throws {
        let state = "Warmian-Masurian"
        let expectedSuffix = "warmińsko-mazurskie"
        
        let translatedState = PolishStates.translate(state: state)
        
        expect(translatedState).to(containPrefix(expectedPrefix))
        expect(translatedState).to(containSuffix(expectedSuffix))
        expect(translatedState).to(contain(" "))
    }
    
    func test_TranslateEmptyState_returns_EmptyName() throws {
        let state = ""
        
        let translatedState = PolishStates.translate(state: state)
        
        expect(translatedState).to(beEmpty())
        expect(translatedState).toNot(contain(" "))
        
    }
    
    func test_TranslateUnknownState_returns_unknownName() throws {
        let state = "Dolnośląskie"
        
        let translatedState = PolishStates.translate(state: state)
        
        expect(translatedState).toNot(containPrefix(expectedPrefix))
        expect(translatedState).to(equal(state))
    }
}
