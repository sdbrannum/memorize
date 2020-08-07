//
//  Cardify.swift
//  Memorize
//
//  Created by Steven Brannum on 8/4/20.
//  Copyright © 2020 Steven Brannum. All rights reserved.
//

import SwiftUI

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct Cardify : ViewModifier {
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
}
