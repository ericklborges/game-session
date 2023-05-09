//
//  CounterListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import SwiftUI

struct CounterListViewState {
    var counters: [Counter] = []
    var shouldCreateCounter = false
}

class CounterListViewModel: ObservableObject {

    // MARK: - State
    @Published private(set) var state: CounterListViewState = .init()

    // MARK: - Bindable State Properties
    var countersBinding: Binding<[Counter]> {
        Binding(to: \.state.counters, in: self)
    }

    var shouldCreateCounterBinding: Binding<Bool> {
        Binding(to: \.state.shouldCreateCounter, in: self)
    }

    // MARK: - DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)

    // MARK: - Init
    init(initialState: CounterListViewState) {
        self.state = state
    }

    // MARK: - Local Storage
    func getAllCounters() {
        state.counters = counterDAO.getAll() ?? []
    }

    func deleteCounter(at index: Int) {
        let selectedCounter = state.counters[index]
        counterDAO.delete(id: selectedCounter.id)
        getAllCounters()
    }

    // MARK: - Actions
    func showCreatCounter() {
        state.shouldCreateCounter = true
    }
}
