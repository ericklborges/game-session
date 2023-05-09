//
//  NewCounterView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 01/05/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct NewCounterView: View {

    enum Field {
        case counterName
    }

    @Environment(\.dismiss) var dismiss
    @State var counterTitle: String = ""
    @State var showInvalidTitleFeedback = false
    @FocusState var focusedField: Field?

    var viewModel = NewCounterViewModel()

    var body: some View {
        Form {
            Text("Choose a title for your new counter")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField(
                "Counter title",
                text: $counterTitle,
                prompt: Text("min. 3 characters")
            )
            .focused($focusedField, equals: .counterName)

            Spacer()

            Button(
                action: {
                    viewModel.createCounter(named: counterTitle)
                    dismiss()
                },
                label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, minHeight: 40)
                }
            )
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .disabled(counterTitle.count < 3)
        }
        .onAppear { focusedField = .counterName }
        .formStyle(.columns)
        .padding()
    }
}

struct NewCounter_Previews: PreviewProvider {
    static var previews: some View {
        NewCounterView()
    }
}
