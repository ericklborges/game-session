//
//  CounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterView: View { 

    @StateObject var viewModel: CounterViewModel
    
    var body: some View {
        VStack(spacing: 16.0) {
            CounterDisplayView(text: viewModel.entriesSumText)
                .layoutPriority(1)

            Spacer()

            CounterButton(function: .add) {
                viewModel.add()
            }

            CounterButton(function: .subtract) {
                viewModel.subtract()
            }

        }
        .padding()
        .background(Color(asset: GameSessionAsset.Colors.textColor))
        .onAppear { viewModel.refreshCounter() }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            NavigationLink(
                destination: { EntriesListView(viewModel.entriesListViewModel) },
                label: { Text("History") }
            )
        }
    }

}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterView(
                viewModel: CounterViewModel(counter: Counter(title: "Foo Counter"))
            )
        }
    }
}
