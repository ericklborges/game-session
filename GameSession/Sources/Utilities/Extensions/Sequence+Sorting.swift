//
//  Sequence+Sorting.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
