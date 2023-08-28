//
//  MemorizeGame.swift
//  memorize
//
//  Created by Htain Lin Shwe on 26/08/2023.
//

import Foundation



struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    
    init(numberOfParisOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfParisOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    // MARK: - Intents
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
    
    
}
