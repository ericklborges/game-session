//
//  EntriesListView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 06/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct EntriesListView: View {

    @ObservedObject var viewModel: EntriesListViewModel

    init(_ gameSessions: [GameSession]) {
        self.viewModel = EntriesListViewModel(gameSessions)
    }

    var body: some View {
        List {
            ForEach(viewModel.sections, content: EntriesListSection.init)
        }
    }
}

struct EntriesListView_Preview: PreviewProvider {

    static var previews: some View {
        EntriesListView(gameSessions)
    }

    static var gameSessions = [
        GameSession(
            timestamp: Date(),
            entries: [
                Entry(timestamp: Date(), value: 1),
                Entry(timestamp: Date(), value: -1),
            ]
        ),
        GameSession(
            timestamp: Date(timeIntervalSinceNow: 86400),
            entries: [
                Entry(timestamp: Date(timeIntervalSinceNow: 1), value: 2),
                Entry(timestamp: Date(timeIntervalSinceNow: 2), value: -2),
            ]
        ),
        GameSession(
            timestamp: Date(timeIntervalSinceNow: -86400),
            entries: [
                Entry(timestamp: Date(timeIntervalSinceNow: -1), value: 3),
                Entry(timestamp: Date(timeIntervalSinceNow: -2), value: -3),
            ]
        ),
    ]
}
