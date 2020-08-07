//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Steven Brannum on 6/18/20.
//  Copyright © 2020 Steven Brannum. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.theme.name)
                    .font(Font.largeTitle)
                Spacer()
                Button(action: {
                    self.viewModel.newGame()
                }) {
                    Text("New Game")
                }
            }
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                    .padding(5)
                    .aspectRatio(2/3, contentMode: .fit)
            }
                .font(viewModel.cards.count == 10 ? Font.subheadline : Font.largeTitle)
                .foregroundColor(viewModel.theme.color)
            
            Text("Score: \(viewModel.score)")
                .font(Font.title)
            
        }.padding([.bottom, .horizontal])
    }
}

struct CardView : View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(
                    startAngle: Angle.degrees(0-90),
                    endAngle: Angle.degrees(110-90),
                    clockwise: true
                )
                    .padding(5).opacity(0.4)
                Text(card.content)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .font(Font.system(size: fontSize(for: size)))
        }
    }
    
    // MARK - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.65
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
