//
//  CounterListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 30/07/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Database_watchOS

struct CounterListViewState {
    var counters: [Counter] = []
}

final class CounterListViewModel: ObservableObject {
    
    @Published private(set) var state = CounterListViewState()
    
    // MARK: - DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)

    // MARK: - Local Storage
    func getAllCounters() {
        let allCounters = counterDAO.getAll() ?? []
        state.counters = allCounters.sorted(by: \.title)
    }
}
