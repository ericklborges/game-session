//
//  SessionViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine

final class SessionViewModel: ObservableObject {

    // MARK: - Published
    @Published var counterText: String = "0"

    // MARK: - Properties
    private var counter = 0 {
        didSet { counterText = String(counter) }
    }

    // MARK: - Actions
    func add() {
        counter += 1
    }

    func subtract() {
        counter -= 1
    }
}
