//
//  MemoryGame.swift
//  Memorize
//
//  Created by Steven Brannum on 6/19/20.
//  Copyright © 2020 Steven Brannum. All rights reserved.
//

import Foundation
import SwiftUI

struct MemoryGame<TCardContentType> where TCardContentType: Hashable {
    private(set) var cards: Array<Card>
    var theme: Theme
    var seenCards: Set<TCardContentType>
    var score: Int
    
    private var indexOfOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(theme: Theme, cardContentFactory: (Int) -> TCardContentType) {
        self.theme = theme
        cards = Array<Card>()
        seenCards = Set<TCardContentType>()
        score = 0
        
        for pairIndex in 0..<theme.numberOfPairs {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        cards.shuffle()
        
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if (seenCards.contains(cards[chosenIndex].content)) {
                        score -= 1
                    }
                    if (seenCards.contains(cards[potentialMatchIndex].content)) {
                        score -= 1
                    }
                }
                self.cards[chosenIndex].isFaceUp = true
                seenCards.insert(cards[chosenIndex].content)
                seenCards.insert(cards[potentialMatchIndex].content)
            } else {
                indexOfOnlyFaceUpCard = chosenIndex
            }
        }
        
    }
    
    struct Card : Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: TCardContentType
    }
    
    struct Theme {
        var name: String
        var contents: [TCardContentType]
        var color: Color
        var numberOfPairs: Int
        
        init(name: String, color: Color, contents: [TCardContentType], numberOfPairs: Int?) {
            self.name = name
            self.color = color
            self.contents = contents
            
            if let pairsOfCards = numberOfPairs {
                self.numberOfPairs = pairsOfCards
            } else {
                self.numberOfPairs = Int.random(in: 2...5)
            }
        }
    }
    


}
