//
//  ContentView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojMemoryGame
    let aspectRatio: CGFloat = 2/3
    
    @State var cardCount = 4
    
    private let spacing: CGFloat = 4
    
    
    
    var body: some View {
        VStack {
            
            cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
        
        
        
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
                
                    CardView(card)
                        .padding(spacing)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                  
                    
        }
           
        
       
    }
    
}





struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojMemoryGame())
    }
}
