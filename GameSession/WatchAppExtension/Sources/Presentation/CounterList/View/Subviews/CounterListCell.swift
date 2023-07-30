//
//  CounterListCell.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 30/07/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Database_watchOS
import SwiftUI

struct CounterListCell<Destination: View>: View {
    
    private let counter: Counter
    private let destination: Destination
    
    private var entriesSum: Int32 { counter.allSessionsEntriesSum }
    
    init(_ counter: Counter, @ViewBuilder destination: () -> Destination) {
        self.counter = counter
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                HStack {
                    Text(counter.title)
                    Spacer()
                    Text("[\(entriesSum)]")
                        .foregroundColor(color(for: entriesSum))
                }
            }
        )
    }
    
    private func color(for amount: Int32) -> Color {
        if amount > 0 {
            return .green
        } else if amount < 0 {
            return .red
        } else {
            return .white
        }
    }
}

struct CounterListCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CounterListCell(
                    Counter(title: "Foo Counter"),
                    destination: { Text("Bar") }
                )
            }
        }
    }
}
