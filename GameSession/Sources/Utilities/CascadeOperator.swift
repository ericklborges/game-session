//
//  CascadeOperator.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 23/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation

prefix operator ..
infix operator ..: MultiplicationPrecedence

@discardableResult
// swiftlint:disable:next static_operator
public func .. <T>(object: T, configuration: (inout T) -> Void) -> T {
    var object = object
    configuration(&object)
    return object
}
