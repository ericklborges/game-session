//
//  CounterViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Foundation

final class CounterViewModel: ObservableObject {

    // MARK: - Published
    @Published var entriesSumText: String = "0"

    // MARK: - Properties
    var gameSessions: [GameSession] { gameCounter.sessions }

    private var entriesSum: Int32 = 0 {
        didSet { entriesSumText = String(entriesSum) }
    }

    private let counterStep: Int32 = 1
    private var gameCounter = Counter(title: "First Counter")

    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let sessionDAO = CDSessionDAO(CoreDataStore.shared.context)

    // MARK: - Init & Setup

    init() {
        setupGameCounter()
    }

    private func setupGameCounter() {
        gameCounter = getCounter()
        entriesSum = gameCounter.allSessionsEntriesSum
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

        // TODO: Improve this logic
        if let currentSession = gameSessions.first {
            let currentSessionDate = currentSession.timestamp.formatted(date: .numeric, time: .omitted)
            let today = Date().formatted(date: .numeric, time: .omitted)

            if currentSessionDate != today {
                addSessionToCounter(newEntry)
            } else {
                sessionDAO.update(id: currentSession.id, adding: newEntry)
            }

        } else {
            addSessionToCounter(newEntry)
        }

        gameCounter = getCounter()
    }

    func addSessionToCounter(_ entry: Entry) {
        let newSession = GameSession(entry: entry)
        counterDAO.update(id: gameCounter.id, adding: newSession)
    }

    // MARK: - Actions

    func add() {
        entriesSum += counterStep
        addEntryToSession(counterStep)
    }

    func subtract() {
        entriesSum -= counterStep
        addEntryToSession(-counterStep)
    }
}
