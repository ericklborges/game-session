//
//  CounterListViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Combine
import Foundation

class CounterListViewModel: ObservableObject {

    // MARK: - Published
    @Published var counters: [Counter] = []

    // MARK: - DAOs
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)

    // MARK: - Local Storage
    func getAllCounters() {
        counters = counterDAO.getAll() ?? []
    }
}
