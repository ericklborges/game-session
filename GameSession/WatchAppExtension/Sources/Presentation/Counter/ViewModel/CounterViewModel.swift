//
//  CounterViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 30/07/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI
import Database_watchOS

struct CounterViewState {
    var title: String = ""
    var amount: Int32 = 0
    
    var amountColor: Color {
        if amount > 0 {
            return .green
        } else if amount < 0 {
            return .red
        } else {
            return .white
        }
    }
}

final class CounterViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var state = CounterViewState()
    private var gameCounter: Counter
    private var gameSessions: [GameSession] { gameCounter.sessions }
    
    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let sessionDAO = CDSessionDAO(CoreDataStore.shared.context)
    
    init(gameCounter: Counter) {
        self.gameCounter = gameCounter
        self.state = makeInitialState(gameCounter)
    }
    
    private func makeInitialState(_ gameCounter: Counter) -> CounterViewState {
        CounterViewState(
            title: gameCounter.title,
            amount: gameCounter.allSessionsEntriesSum
        )
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
    func increment() {
        addEntryToSession(1)
    }

    func decrement() {
        addEntryToSession(-1)
    }

    func refreshCounter() {
        gameCounter = counterDAO.get(id: gameCounter.id) ?? Counter(title: "Corrupted Counter")
        state.amount = gameCounter.allSessionsEntriesSum
    }
}
