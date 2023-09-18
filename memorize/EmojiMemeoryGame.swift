//
//  EmojiMemeoryGame.swift
//  memorize
//
//  Created by Htain Lin Shwe on 26/08/2023.
//

import SwiftUI




class EmojMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card

    private static let emojis = ["👻","🐵","🐶","🐷","🌝","🔥","⛈️","🐚","🐼", "🐙" , "🐢","🦀","🦄","🕷️","🦫"]
    
    
    var color: Color {
        .orange
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfParisOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            }
            return "⁉️"
        }
    }
    
    
    @Published private var model = createMemoryGame()
    
    
    
    var cards: Array<Card> {
         model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        
    }
    
    func choose(_ card: Card) {
        withAnimation {
            model.choose(card)
        }
    }
    
}
