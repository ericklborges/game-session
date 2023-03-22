//
//  EntriesListRow.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 06/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct EntriesListRow: View {

    struct State: Identifiable {
        let id: String
        let amount: String
        let time: String
    }

    let state: State

    init(_ state: State) {
        self.state = state
    }

    var body: some View {
        HStack {
            Text(state.amount)
            Spacer()
            Text(state.time)
        }
    }
    
}

struct EntriesListRow_Preview: PreviewProvider {

    static var state = EntriesListRow.State(
        id: "",
        amount: "1",
        time: Date().formatted()
    )

    static var previews: some View {
        EntriesListRow(state)
    }
}
