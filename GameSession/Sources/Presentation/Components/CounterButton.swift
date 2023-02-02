//
//  CounterButton.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterButton: View {
    
    enum Function {
        case add, subtract
    }
    
    private let function: Function
    private let action: () -> Void
    
    init(function: Function, action: @escaping () -> Void) {
        self.function = function
        self.action = action
    }
    
    var body: some View {
        Button("", action: action)
            .buttonStyle(CounterButtonStyle(function: function))
            .frame(maxHeight: 200)
    }
}

// MARK: - Styles

fileprivate struct CounterButtonStyle: ButtonStyle {

    struct ImageSet {
        let normal: GameSessionImages
        let pressed: GameSessionImages
        
        static let up = ImageSet(
            normal: GameSessionAsset.Assets.buttonUpIdle,
            pressed: GameSessionAsset.Assets.buttonUpPressed
        )
        
        static let down = ImageSet(
            normal: GameSessionAsset.Assets.buttonDownIdle,
            pressed: GameSessionAsset.Assets.buttonDownPressed
        )
    }
    
    let function: CounterButton.Function
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let imageSet: ImageSet = function == .add ? .up : .down
        let image = configuration.isPressed ? imageSet.pressed : imageSet.normal
         
        if configuration.isPressed {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
            
        return Image(asset: image)
            .resizable()
            .frame(maxHeight: 200)
            .scaleEffect(x: 1, y: configuration.isPressed ? 0.95 : 1, anchor: .bottom)
    }
}

struct CounterButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32.0) {
            CounterButton(function: .add, action: { print("action") })
            CounterButton(function: .subtract, action: { print("action") })
        }
        .padding()
    }
}
