//
//  GameSessionListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 14/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine

class GameSessionListViewModel: ObservableObject {

    // MARK: - Published
    @Published var sections: [GameSessionListSection.State] = []

    // MARK: - Properties
    private let gameSessions: [GameSession]

    // MARK: - Init & Setup
    init(_ gameSessions: [GameSession]) {
        self.gameSessions = gameSessions
        setupSections()
    }

    private func setupSections() {
        sections = gameSessions
            .sorted(by: { $1.timestamp > $0.timestamp })
            .map { makeSection($0) }
    }

    private func makeSection(_ session: GameSession) -> GameSessionListSection.State {
        .init(
            id: session.id.uuidString,
            title: session.timestamp.formatted(date: .numeric, time: .omitted),
            rows: session.entries.map { makeRow($0) }
        )
    }

    private func makeRow(_ entry: Entry) -> GameSessionListRow.State {
        .init(
            id: entry.id.uuidString,
            amount: String(entry.value),
            time: entry.timestamp.formatted(date: .omitted, time: .standard)
        )
    }
}
