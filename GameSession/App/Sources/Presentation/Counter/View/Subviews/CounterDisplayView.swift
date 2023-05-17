//
//  CounterDisplayView.swift
//  GameSession
//
//  Created by Erick Lozano Borges on 31/01/23.
//  Copyright © 2023 bcl. All rights reserved.
//

import SwiftUI

struct CounterDisplayView: View {
   
    private let textFont = GameSessionFontFamily.PixelSplitter.regular.font(size: 50)
    
    let text: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(asset: GameSessionAsset.Assets.screen)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
            Text(text)
                .foregroundColor(.init(asset: GameSessionAsset.Colors.textColor))
                .font(.custom(textFont.fontName, size: textFont.pointSize))
                .alignmentGuide(VerticalAlignment.center) { context in
                    context.height
                }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterDisplayView(text: "+1")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
