//
//  NewCounterViewModel.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Database_iOS

class NewCounterViewModel {
    // MARK: - DAO
    private let counterDAO = CDCounterDAO(CoreDataStore.shared.context)

    // MARK: - Local Database
    func createCounter(named title: String) {
        counterDAO.create(title: title)
    }
}
