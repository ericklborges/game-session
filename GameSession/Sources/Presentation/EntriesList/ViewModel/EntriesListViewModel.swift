//
//  EntriesListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 14/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Foundation

class EntriesListViewModel: ObservableObject {

    // MARK: - Published
    @Published var sections: [EntriesListView.SectionData] = []

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
        updateSections(with: counter)
    }

    func clearAllSessionsInCounter() {
        guard let clearedCounter = counterDAO.clearSessions(id: counterId) else { return }
        updateSections(with: clearedCounter)
    }

    // FIXME: Pass entry id directly
    func deleteEntry(index: Int, sessionId: UUID) {
        guard let counter = counterDAO.get(id: counterId) else { return }
        guard let selectedSession = counter.sessions.first(where: { $0.id == sessionId }) else { return }
        let selectedEntry = selectedSession.entries[index]
        entryDAO.delete(id: selectedEntry.id)
        fetchCounter()
    }

    // MARK: - State Building
    private func updateSections(with counter: Counter) {
        sections = counter.sessions.map { makeSection($0) }
    }

    private func makeSection(_ session: GameSession) -> EntriesListView.SectionData {
        .init(
            id: session.id,
            title: session.timestamp.formatted(date: .numeric, time: .omitted),
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
