//
//  MemorizeGame.swift
//  memorize
//
//  Created by Htain Lin Shwe on 26/08/2023.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
    
}
