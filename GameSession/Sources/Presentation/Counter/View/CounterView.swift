//
//  CounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterView: View {

    @StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        NavigationView {
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

                NavigationLink(
                    destination: { EntriesListView(viewModel.gameSessions) },
                    label: { Text("History") }
                )
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)

            }
            .padding()
            .background(Color(asset: GameSessionAsset.Colors.textColor))
        }
    }

}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
