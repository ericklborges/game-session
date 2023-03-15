//
//  CounterViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine

final class CounterViewModel: ObservableObject {

    // MARK: - Published
    @Published var counterText: String = "0"

    // MARK: - Properties
    var gameSessions: [GameSession] {
        gameCounter.sessions
    }

    private var counter: Int32 = 0 {
        didSet { counterText = String(counter) }
    }

    private let counterStep: Int32 = 1
    private var gameCounter = Counter("First Counter")
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let sessionDAO = CDSessionDAO(CoreDataStore.shared.context)

    // MARK: - Init & Setup

    init() {
        setupGameCounter()
    }

    private func setupGameCounter() {
        gameCounter = getCounter()
        counter = gameCounter
            .sessions
            .map(\.entries)
            .reduce([], +)
            .map(\.value)
            .reduce(0, +)
    }

    // MARK: - Local Storage

    func getCounter() -> Counter {
        guard let counters = counterDAO.getAll() else {
            return gameCounter
        }

        if let firstCounter = counters.first {
            return firstCounter
        }

        if let newCounter = counterDAO.create(title: "First Counter") {
            return newCounter
        }

        return gameCounter
    }

    func addEntryToSession(_ value: Int32) {
        let newEntry = Entry(value: value)

        if let currentSession = gameCounter.sessions.last {
            sessionDAO.update(id: currentSession.id, adding: newEntry)
        } else {
            let newSession = GameSession(entry: newEntry)
            counterDAO.update(id: gameCounter.id, adding: newSession)
        }

        gameCounter = getCounter()
    }

    // MARK: - Actions

    func add() {
        counter += counterStep
        addEntryToSession(counterStep)
    }

    func subtract() {
        counter -= counterStep
        addEntryToSession(-counterStep)
    }
}
