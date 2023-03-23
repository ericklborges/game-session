//
//  EntriesListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 14/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine

class EntriesListViewModel: ObservableObject {

    // MARK: - Published
    @Published var sections: [EntriesListSection.State] = []

    // MARK: - Properties
    private var counter: Counter

    // MARK: DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)

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

    // MARK: - State Build
    private func makeSection(_ session: GameSession) -> EntriesListSection.State {
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
