//
//  NewCounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct NewCounterView: View {

    @Environment(\.dismiss) var dismiss
    @State var counterTitle: String = ""
    @State var showInvalidTitleFeedback = false

    var viewModel = NewCounterViewModel()

    var body: some View {
        VStack {
            Text("Choose a title for your new counter")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField(
                "Counter title",
                text: $counterTitle,
                prompt: Text("ex: Rocket League 1x1")
            )

            if showInvalidTitleFeedback {
                Text("min. 3 characters")
                    .bold()
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer()

            Button(
                action: {
                    let isTitleValid = counterTitle.count > 3
                    showInvalidTitleFeedback = !isTitleValid
                    if isTitleValid {
                        viewModel.createCounter(named: counterTitle)
                        dismiss()
                    }
                },
                label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
            )
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
        }
        .padding()
    }
}

struct NewCounter_Previews: PreviewProvider {
    static var previews: some View {
        NewCounterView()
    }
}
