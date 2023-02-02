//
//  SessionView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct SessionView: View {
    
    @State var counter = 0
    
    var body: some View {
        VStack(spacing: 16.0) {
            CounterView(text: String(counter))
                .layoutPriority(1)
            Spacer()
            CounterButton(function: .add) { counter += 1 }
            CounterButton(function: .subtract) { counter -= 1 }
        }
        .padding()
        .background(Color(asset: GameSessionAsset.Colors.textColor))
    }
    
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
