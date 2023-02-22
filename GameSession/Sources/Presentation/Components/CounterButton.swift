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
        let arrow: GameSessionImages
        let normal: GameSessionImages
        let pressed: GameSessionImages
        
        static let up = ImageSet(
            arrow: GameSessionAsset.Assets.buttonArrowUp,
            normal: GameSessionAsset.Assets.buttonBackgroundUpIdle,
            pressed: GameSessionAsset.Assets.buttonBackgroundUpPressed
        )
        
        static let down = ImageSet(
            arrow: GameSessionAsset.Assets.buttonArrowDown,
            normal: GameSessionAsset.Assets.buttonBackgroundDownIdle,
            pressed: GameSessionAsset.Assets.buttonBackgroundDownPressed
        )
    }
    
    let function: CounterButton.Function
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let imageSet: ImageSet = function == .add ? .up : .down
        let backgroundImage = configuration.isPressed ? imageSet.pressed : imageSet.normal
        let arrowImage = imageSet.arrow
         
        if configuration.isPressed {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }

        return ZStack {
            Image(asset: backgroundImage)
                .resizable()

            Image(asset: arrowImage)
                .resizable()
                .scaledToFit()
                .padding([.top, .bottom], 44)
        }
        .frame(maxHeight: 200)
        .scaleEffect(x: 1, y: configuration.isPressed ? 0.95 : 1, anchor: .bottom)

    }
}

struct CounterButton_Previews: PreviewProvider {
    static var previews: some View {
        previewOnDevice("iPhone 14 Pro")
        previewOnDevice("iPhone 13 mini")
        previewOnDevice("iPhone 8 Plus")
        previewOnDevice("iPhone SE (3rd generation)")
    }

    static func previewOnDevice(_ previewDevice: PreviewDevice? = nil) -> some View {
        VStack(spacing: 32.0) {
            CounterButton(function: .add, action: { print("action") })
            CounterButton(function: .subtract, action: { print("action") })
        }
        .padding()
        .previewDevice(previewDevice)
    }
}
