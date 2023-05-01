//
//  CounterListView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterListView: View {

    @State var newCounterName = ""
    @State var showNewCounterView = false

    @ObservedObject var viewModel = CounterListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.counters) {
                    CounterListCell($0)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Counters")
            .navigationBarTitleDisplayMode(.large)
            .onAppear { refreshCounters() }
            .toolbar {
                Button(
                    action: { showNewCounterView = true },
                    label: { Image(systemName: "plus") }
                )
                .sheet(
                    isPresented: $showNewCounterView,
                    onDismiss: { refreshCounters() },
                    content: { NewCounterView() }
                )
            }
        }
    }

    private func refreshCounters() {
        viewModel.getAllCounters()
    }
}

struct CounterListView_Previews: PreviewProvider {
    static var previews: some View {
        CounterListView()
    }
}
