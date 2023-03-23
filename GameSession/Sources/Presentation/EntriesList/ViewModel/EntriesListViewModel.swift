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
    var navigationTitle: String { String(counter.allSessionsEntriesSum) }

    private var counter: Counter

    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)
    private let entryDAO = CDEntryDAO(CoreDataStore.shared.context)

    // MARK: - Init & Setup
    init(counter: Counter) {
        self.counter = counter
        updateSections()
    }

    private func updateSections() {
        sections = counter.sessions.map { makeSection($0) }
    }

    // MARK: - Local Storage
    func clearAllSessions() {
        guard let clearedCounter = counterDAO.clearSessions(id: counter.id) else { return }
        counter = clearedCounter
        updateSections()
    }

    func deleteEntry(index: Int, sessionId: UUID) {
        guard let selectedSession = counter.sessions.first(where: { $0.id == sessionId }) else { return }
        let selectedEntry = selectedSession.entries[index]
        entryDAO.delete(id: selectedEntry.id)

        if let updatedCounter = counterDAO.get(id: counter.id) {
            counter = updatedCounter
            updateSections()
        }
    }

    // MARK: - State Build
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
