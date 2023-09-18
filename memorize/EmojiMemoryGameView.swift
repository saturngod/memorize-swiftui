//
//  ContentView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojMemoryGame
    let aspectRatio: CGFloat = 2/3
    
    @State var cardCount = 4
    
    private let spacing: CGFloat = 4
    
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            
            cards
                .foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundColor(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
            
        }
        .padding()
        
        
        
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
  
    var cardCounterAdjuster: some View {
        HStack {
            
            cardRemover
            Spacer()
            cardAdder
        
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    
 
        
    func cardCounterAdjuster(by offset: Int, symbols: String) -> some View {
        
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbols)
        })
        .disabled(cardCount + offset > viewModel.cards.count || cardCount + offset < 1)
        
    }
        
    
    var cardAdder: some View {
       cardCounterAdjuster(by: +1, symbols: "folder.fill.badge.plus")
    }
    
    var cardRemover: some View {
        cardCounterAdjuster(by: -1, symbols: "folder.fill.badge.minus")
    }
    
    
    private var cards: some View {
        
        AspectVGrid(items: viewModel.cards,aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                   
                    
            }
            
                  
                    
        }
        
           
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0)}
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth/aspectRatio)
        .onTapGesture  {
           deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    //tuple
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount,id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    
    
}





struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojMemoryGame())
    }
}
