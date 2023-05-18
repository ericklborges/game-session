//
//  CounterViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 22/02/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Database_iOS

final class CounterViewModel: ObservableObject {

    // MARK: - Published
    @Published var entriesSumText: String = "0"
    var navigationTitle: String { gameCounter.title }

    // MARK: - Properties
    var entriesListViewModel: EntriesListViewModel {
        .init(counterId: gameCounter.id)
    }

    private var gameSessions: [GameSession] { gameCounter.sessions }
    private var gameCounter: Counter
    private let counterStep: Int32 = 1

    private var entriesSum: Int32 = 0 {
        didSet { entriesSumText = String(entriesSum) }
    }

    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let sessionDAO = CDSessionDAO(CoreDataStore.shared.context)

    // MARK: - Init & Setup
    init(counter: Counter) {
        gameCounter = counter
        updateEntriesSum()
    }

    private func updateEntriesSum() {
        entriesSum = gameCounter.allSessionsEntriesSum
    }

    // MARK: - Local Storage
    func addEntryToSession(_ value: Int32) {
        let newEntry = Entry(value: value)

        // TODO: Improve this logic
        if let currentSession = gameSessions.first {
            let currentSessionDate = currentSession.timestamp
            let wasCurrentSessionCreatedToday = currentSessionDate.isSameDayMonthYear(as: .today)

            if wasCurrentSessionCreatedToday {
                sessionDAO.update(id: currentSession.id, adding: newEntry)
            } else {
                addSessionToCounter(newEntry)
            }

        } else {
            addSessionToCounter(newEntry)
        }

        refreshCounter()
    }

    private func addSessionToCounter(_ entry: Entry) {
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

    func refreshCounter() {
        gameCounter = counterDAO.get(id: gameCounter.id) ?? Counter(title: "Corrupted Counter")
        updateEntriesSum()
    }
}
