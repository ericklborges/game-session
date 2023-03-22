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
            timestamp: .today,
            entries: [
                Entry(timestamp: .today, value: 1),
                Entry(timestamp: .today, value: -1),
            ]
        ),
        GameSession(
            timestamp: .tomorrow,
            entries: [
                Entry(timestamp: .today.add(1, to: .second), value: 2),
                Entry(timestamp: .today.add(2, to: .second), value: -2),
            ]
        ),
        GameSession(
            timestamp: .yesterday,
            entries: [
                Entry(timestamp: .today.add(-1, to: .second), value: 3),
                Entry(timestamp: .today.add(-2, to: .second), value: -3),
            ]
        ),
    ]
}
