//
//  MemorizeGame.swift
//  memorize
//
//  Created by Htain Lin Shwe on 26/08/2023.
//

import Foundation



struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card> = []
    
    
    init(numberOfParisOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        
        for pairIndex in 0..<numberOfParisOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            self.cards.append(Card(id: "\(pairIndex+1)a", content: content))
            self.cards.append(Card( id: "\(pairIndex+1)b", content: content))
        }
        
        
        
        
    }
    
    // MARK: - Intents
    
    mutating func shuffle() {
        self.cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    
                } else {
                  
                    indexOfTheOneAndOnlyFaceUpCard =  chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            
        }
    }
    
    func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index;
            }
        }
        return nil
    }
    
    struct Card: Equatable, Identifiable {
        var id: String
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
    
    
}


extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
