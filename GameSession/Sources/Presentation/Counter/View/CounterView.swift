//
//  CounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterView: View {

    // TODO: @StateObject vs ObservedObject
    @StateObject var viewModel = CounterViewModel()
    
    var body: some View {
        VStack(spacing: 16.0) {
            CounterDisplayView(text: viewModel.counterText)
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
    }

}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
