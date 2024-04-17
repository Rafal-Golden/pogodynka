//
//  Contain+Nimble.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 17/04/2024.
//

import Nimble

func containPrefix(_ prefix: String) -> Matcher<String> {
    return Matcher.define("contains prefix \(prefix)") { expression, msg in
        if let actualValue = try expression.evaluate() {
            let matches = actualValue.hasPrefix(prefix)
            return MatcherResult(bool: matches, message: msg)
        } else {
            return MatcherResult(status: .fail, message: msg)
        }
    }
}

func containSuffix(_ suffix: String) -> Matcher<String> {
    return Matcher.define("contains suffix \(suffix)") { expression, msg in
        if let actualValue = try expression.evaluate() {
            let matches = actualValue.hasSuffix(suffix)
            return MatcherResult(bool: matches, message: msg)
        } else {
            return MatcherResult(status: .fail, message: msg)
        }
    }
}

