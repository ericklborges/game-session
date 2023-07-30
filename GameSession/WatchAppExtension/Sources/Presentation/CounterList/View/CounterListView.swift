//
//  CounterListView.swift
//  WatchAppExtension
//
//  Created by Erick Lozano Borges on 17/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI
import Database_watchOS

struct CounterListView: View {
    
    @ObservedObject var viewModel = CounterListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.state.counters) { counter in
                        CounterListCell(counter) {
                            makeCounterView(for: counter)
                        }
                    }
                } footer: {
                    VStack {
                        Spacer(minLength: 8)
                        Button("Refresh") { viewModel.getAllCounters() }
                            .buttonStyle(.borderedProminent)
                    }
                }
                
            }
            .navigationTitle("Counters")
            .onAppear { viewModel.getAllCounters() }
        }
    }
    
    private func makeCounterView(for counter: Counter) -> CounterView {
        let viewModel = CounterViewModel(gameCounter: counter)
        return CounterView(viewModel: viewModel)
    }
}

struct CounterListView_Previews: PreviewProvider {
    static var previews: some View {
        CounterListView()
    }
}
