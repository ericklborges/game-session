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
            ForEach(viewModel.sections) {
                EntriesListSection($0, onDeleteRow: viewModel.deleteEntry)
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
        }
        .navigationTitle(viewModel.navTitle)
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
