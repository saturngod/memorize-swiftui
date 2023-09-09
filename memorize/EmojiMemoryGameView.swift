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
            
            cards.animation(.default, value: viewModel.cards)
            
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
    
    @ViewBuilder
    var cards: some View {
        
        let aspectRadio: CGFloat = 2/3
        GeometryReader { geometry in
            
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRadio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)], spacing: 0)
            {
                ForEach(viewModel.cards) { card in
                    
                        CardView(card)
                            .aspectRatio(aspectRadio, contentMode: .fit)
                            .padding(4)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    
                }
            }
        }
        
        .foregroundColor(.orange)
    }
    
}

func gridItemWidthThatFits(
    count: Int,
    size: CGSize,
    atAspectRatio aspectRadio: CGFloat
) -> CGFloat {
    
    
    
    let count = CGFloat(count)
    var columnCount = 1.0
    
    repeat {
        let width = size.width / columnCount
        let height = width / aspectRadio
        
        let rowCount = (count/columnCount).rounded(.up)
        
        if rowCount * height < size.height {
            print("HERE")
            return (size.width / columnCount).rounded(.down)
        }
        columnCount += 1
        
    } while columnCount < count
    
    print("SIZE HEIGHT \(size.height)")
          
    return min(size.width / count, size.height * aspectRadio).rounded(.down)
    
}



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojMemoryGame())
    }
}
