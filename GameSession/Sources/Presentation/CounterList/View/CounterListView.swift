//
//  CounterListView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterListView: View {

    // MARK: - Properties

    @ObservedObject var viewModel = CounterListViewModel(initialState: .init())

    // MARK: - Views

    var body: some View {
        NavigationView {
            counterList
                .navigationTitle("Counters")
                .navigationBarTitleDisplayMode(.large)
                .toolbar { addButton }
                .onAppear(perform: refreshCounters)
                .refreshable { refreshCounters() }
        }
    }

    private var counterList: some View {
        List {
            ForEach(
                viewModel.state.counters,
                content: CounterListCell.init
            )
            .onDelete {
                guard let selectedCounterIndex = $0.first else { return }
                viewModel.deleteCounter(at: selectedCounterIndex)
            }
        }
        .listStyle(.plain)
    }

    private var addButton: some View {
        Button(
            action: viewModel.showCreatCounter,
            label: { Image(systemName: "plus") }
        )
        .sheet(
            isPresented: viewModel.shouldCreateCounterBinding,
            onDismiss: refreshCounters,
            content: { NewCounterView() }
        )
    }

    // MARK: - Actions

    private func refreshCounters() {
        viewModel.getAllCounters()
    }
}

struct CounterListView_Previews: PreviewProvider {
    static var previews: some View {
        CounterListView()
    }
}
