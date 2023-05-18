//
//  EntriesListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 14/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Database_iOS
import Foundation

class EntriesListViewModel: ObservableObject {

    // MARK: - Published
    @Published var navTitle: String = ""
    @Published var sections: [EntriesListSection.State] = []

    // MARK: - Properties
    private let counterId: UUID

    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let entryDAO = CDEntryDAO(CoreDataStore.shared.context)

    // MARK: - Init & Setup
    init(counterId: UUID) {
        self.counterId = counterId
        fetchCounter()
    }

    // MARK: - Local Storage
    func fetchCounter() {
        guard let counter = counterDAO.get(id: counterId) else { return }
        updateState(with: counter)
    }

    func deleteEntry(_ entryRow: EntriesListRow.State) {
        entryDAO.delete(id: entryRow.id)
        fetchCounter()
    }

    func clearAllSessionsInCounter() {
        guard let clearedCounter = counterDAO.clearSessions(id: counterId) else { return }
        updateState(with: clearedCounter)
    }

    // MARK: - State Building
    private func updateState(with counter: Counter) {
        navTitle = String(counter.allSessionsEntriesSum)
        sections = counter.sessions.map { makeSection($0) }
    }

    private func makeSection(_ session: GameSession) -> EntriesListSection.State {
        .init(
            id: session.id,
            title: session.timestamp.formatted(date: .numeric, time: .omitted) + " [\(session.entriesSum)]",
            rows: session.entries.map { makeRow($0) }
        )
    }

    private func makeRow(_ entry: Entry) -> EntriesListRow.State {
        .init(
            id: entry.id,
            amount: String(entry.value),
            time: entry.timestamp.formatted(date: .omitted, time: .standard)
        )
    }
}
