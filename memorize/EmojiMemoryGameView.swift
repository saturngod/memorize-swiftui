//
//  ContentView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojMemoryGame
    
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
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
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120),spacing: 0)], spacing: 0)
        {
            ForEach(viewModel.cards.indices,id:\.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
}



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojMemoryGame())
    }
}
