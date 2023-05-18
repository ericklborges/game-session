//
//  CounterListCell.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import Database_iOS
import SwiftUI

struct CounterListCell: View {
    let counter: Counter

    init(_ counter: Counter) {
        self.counter = counter
    }

    var body: some View {
        NavigationLink(
            destination: { makeCounterView() },
            label: {
                HStack {
                    Text(counter.title)

                    let entriesSum = counter.allSessionsEntriesSum

                    if entriesSum == 0 {
                        Text("[\(entriesSum)]")
                    } else if entriesSum > 0 {
                        Text("[\(entriesSum)]")
                            .foregroundColor(.green)
                    } else {
                        Text("[\(entriesSum)]")
                            .foregroundColor(.red)
                    }
                }
            }
        )
    }

    private func makeCounterView() -> CounterView {
        let viewModel = CounterViewModel(counter: counter)
        return CounterView(viewModel: viewModel)
    }
}

struct CounterListCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CounterListCell(
                    Counter(title: "Foo Counter")
                )
            }
        }
    }
}
