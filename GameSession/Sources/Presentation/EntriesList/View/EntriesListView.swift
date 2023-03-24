//
//  EntriesListView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 06/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct EntriesListView: View {

    struct SectionData: Identifiable {
        let id: UUID
        let title: String
        let rows: [EntriesListRow.State]
    }

    @State private var showingAlert = false
    @ObservedObject var viewModel: EntriesListViewModel

    init(_ viewModel: EntriesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.sections) { section in
                Section(section.title) {
                    ForEach(section.rows, content: EntriesListRow.init)
                        .onDelete {
                            deleteEntry(indexSet: $0, sessionId: section.id)
                        }
                }
            }
        }
        .toolbar {
            Button("Clear") {
                showingAlert = true
            }
            .alert("All entries will be discarded.", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) { }

                Button("Discard", role: .destructive) {
                    viewModel.clearAllSessionsInCounter()
                }
            }
        } // FIXME: navigation title back again
    }

    func deleteEntry(indexSet: IndexSet, sessionId: UUID) {
        guard let selectedEntryIndex = indexSet.first else { return }
        viewModel.deleteEntry(index: selectedEntryIndex, sessionId: sessionId)
    }
}

struct EntriesListView_Preview: PreviewProvider {

    static var previews: some View {
        NavigationView {
            EntriesListView(viewModelStub)
        }
    }

    static var viewModelStub = EntriesListViewModel(counterId: UUID())
}
