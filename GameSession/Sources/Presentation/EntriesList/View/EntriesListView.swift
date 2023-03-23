//
//  EntriesListView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 06/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct EntriesListView: View {

    @State private var showingAlert = false
    @ObservedObject var viewModel: EntriesListViewModel

    init(_ viewModel: EntriesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.sections, content: EntriesListSection.init)
        }
        .toolbar {
            Button("Clear") {
                showingAlert = true
            }
            .alert("All entries will be discarded.", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) { }

                Button("Discard", role: .destructive) {
                    viewModel.clearAllSessions()
                }
            }
        }
    }
}

struct EntriesListView_Preview: PreviewProvider {

    static var previews: some View {
        NavigationView {
            EntriesListView(viewModelStub)
        }
    }

    static var viewModelStub = EntriesListViewModel(
        counter: Counter(
            title: "",
            sessions: [
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
        )
    )
}
