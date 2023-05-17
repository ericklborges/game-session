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
        NavigationView{
            Form {
                titleLabel
                textField
                Spacer()
                saveButton
            }
            .formStyle(.columns)
            .padding()
            .toolbar { cancelButton }
            .navigationTitle("New Counter")
            .onAppear { focusedField = .counterName }
        }
    }

    private var saveButton: some View {
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

    private var titleLabel: some View {
        Text("Choose a title")
            .bold()
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var textField: some View {
        TextField(
            "Counter title",
            text: $counterTitle,
            prompt: Text("min. 3 characters")
        )
        .focused($focusedField, equals: .counterName)
    }

    private var cancelButton: some View {
        Button(
            action: { dismiss() },
            label: { Text("Cancel") }
        )
    }
}

struct NewCounter_Previews: PreviewProvider {
    static var previews: some View {
        NewCounterView()
            .navigationTitle("Preview")
    }
}
