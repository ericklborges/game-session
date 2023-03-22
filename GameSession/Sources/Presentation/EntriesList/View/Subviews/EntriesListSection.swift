//
//  EntriesListSection.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 06/03/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct EntriesListSection: View {

    struct State: Identifiable {
        let id: String
        let title: String
        let rows: [EntriesListRow.State]
    }

    let state: State

    init(_ state: State) {
        self.state = state
    }

    var body: some View {
        Section(state.title) {
            ForEach(state.rows, content: EntriesListRow.init)
        }
    }

}

struct EntriesListSection_Preview: PreviewProvider {

    static var state = EntriesListSection.State(
        id: "",
        title: "06/03/2023",
        rows: [
            .init(id: "", amount: "1", time: Date().formatted()),
            .init(id: "", amount: "2", time: Date().formatted()),
            .init(id: "", amount: "3", time: Date().formatted()),
        ]
    )

    static var previews: some View {
        List{
            EntriesListSection(state)
            EntriesListSection(state)
        }
    }
}

