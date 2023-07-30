//
//  CounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 30/07/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI
import Database_watchOS

struct CounterView: View {
    
    @ObservedObject var viewModel: CounterViewModel
    
    var body: some View {
        LazyVStack {
            Text(viewModel.state.title)
                .font(.title)
                .lineLimit(3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 20)
            
            Stepper(
                label: { Text(String(viewModel.state.amount)) },
                onIncrement: { viewModel.increment() },
                onDecrement: { viewModel.decrement() }
            )
            .foregroundColor(viewModel.state.amountColor)
        }
    }
    
}

struct CounterView_Previews: PreviewProvider {
    
    static var viewModelStub: CounterViewModel {
        CounterViewModel(
            gameCounter: Counter(
                id: UUID(),
                title: "Preview Counter",
                sessions: [
                    GameSession(entries: [Entry(value: 1)]),
                    GameSession(entries: [Entry(value: 2)])
                ]
            )
        )
    }
    
    static var previews: some View {
        NavigationView {
            CounterView(viewModel: viewModelStub)
        }
    }
}
