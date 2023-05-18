//
//  CounterListView.swift
//  WatchAppExtension
//
//  Created by Erick Lozano Borges on 17/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach((1..<5)) { i in
                    NavigationLink {
                        DestinationView()
                    } label: {
                        Text("Counter \(i)")
                    }
                }
            }
            .navigationTitle("Counters")
        }
    }
}

struct DestinationView: View {
    var body: some View {
        Text("Selected Counter")
    }
}

struct CounterListView_Previews: PreviewProvider {
    static var previews: some View {
        CounterListView()
    }
}
