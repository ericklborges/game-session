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
         let id: UUID
         let title: String
         let rows: [EntriesListRow.State]
     }

     let state: State
     let onDeleteRow: (EntriesListRow.State) -> Void

     init(
        _ state: State,
        onDeleteRow: @escaping (EntriesListRow.State) -> Void
     ) {
         self.state = state
         self.onDeleteRow = onDeleteRow
     }

     var body: some View {
         Section(state.title) {
             ForEach(state.rows) { EntriesListRow($0) }
                 .onDelete {
                     guard let selectedEntryIndex = $0.first else { return }
                     onDeleteRow(state.rows[selectedEntryIndex])
                 }
         }
     }

 }

 struct EntriesListSection_Preview: PreviewProvider {

     static var state = EntriesListSection.State(
         id: UUID(),
         title: "06/03/2023",
         rows: [
             .init(id: UUID(), amount: "1", time: Date().formatted()),
             .init(id: UUID(), amount: "2", time: Date().formatted()),
             .init(id: UUID(), amount: "3", time: Date().formatted()),
         ]
     )

     static var previews: some View {
         List{
             EntriesListSection(state, onDeleteRow: { _ in })
             EntriesListSection(state, onDeleteRow: { _ in })
         }
     }
 }
