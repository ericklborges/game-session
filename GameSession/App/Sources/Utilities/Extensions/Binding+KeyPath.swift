//
//  Binding+KeyPath.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 09/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

extension Binding {
    init<Object: AnyObject>(
        to path: ReferenceWritableKeyPath<Object, Value>,
        in object: Object
    ) {
        self.init(
            get: { object[keyPath: path] },
            set: { object[keyPath: path] = $0 }
        )
    }
}
