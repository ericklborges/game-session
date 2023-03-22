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
    private let gameSessions: [GameSession]

    // MARK: - Init & Setup
    init(_ gameSessions: [GameSession]) {
        self.gameSessions = gameSessions
        setupSections()
    }

    private func setupSections() {
        sections = gameSessions.map { makeSection($0) }
    }

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
