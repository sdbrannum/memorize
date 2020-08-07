//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Steven Brannum on 6/19/20.
//  Copyright © 2020 Steven Brannum. All rights reserved.
//

import Foundation
import SwiftUI


class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String> = EmojiMemoryGame.createGame()
    
    private static func createGame() -> MemoryGame<String> {
        let pairCount = Int.random(in: 2...5)
        let randTheme = Themes.allCases.randomElement()
        let theme = Themes.create(theme: randTheme!, numberOfPairs: pairCount)
        return MemoryGame<String>(theme: theme) { pairIndex in
            return theme.contents[pairIndex]
        }
    }
    
    // MARK: - getters
    var theme: MemoryGame<String>.Theme {
        game.theme
    }
    
    var themes: [String] {
        return Themes.allCases.map { $0.rawValue }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: - intents
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
    
    func newGame() {
        game = EmojiMemoryGame.createGame()
    }
    
    enum Themes: String, CaseIterable {
        case halloween = "Halloween"
        case animals = "Animals"
        case sports = "Sports"
        case faces = "Faces"
        case vehicles = "Vehicles"
        case flags = "Flags"
        
        static func create(theme: Themes, numberOfPairs: Int) -> MemoryGame<String>.Theme {
            switch(theme) {
            case .halloween:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.orange, contents: ["👻", "🎃", "🕷", "😈", "🍭"], numberOfPairs: numberOfPairs)
            case .animals:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.purple, contents: ["🐶", "🐸", "🐔", "🐒", "🐍"], numberOfPairs: numberOfPairs)
            case .sports:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.blue, contents: ["🎾", "🏈", "⚾️", "⚽️", "🏀"], numberOfPairs: numberOfPairs)
            case .faces:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.pink, contents: ["😇", "😎", "😍", "😠", "🙃"], numberOfPairs: numberOfPairs)
            case .vehicles:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.green, contents: ["🚜", "🚁", "🚒", "🚗", "🚎"], numberOfPairs: numberOfPairs)
            case .flags:
                return MemoryGame<String>.Theme(name: theme.rawValue, color: Color.red, contents: ["🇬🇧", "🇨🇦", "🇹🇩", "🇲🇾", "🇯🇵"], numberOfPairs: numberOfPairs)
            }
        }
    }
}
