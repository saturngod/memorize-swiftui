//
//  CardView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    var card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scalFactor = smallest / largest
        }
        
    }
    
    var body: some View {
       
        TimelineView(.animation) { timeline in
            
            if(card.isFaceUp || !card.isMatched) {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.Pie.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.opacity)
            } else {
                Color.clear
            }
            
            
        }
        
        
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size:Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scalFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1,contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.easeIn(duration: 2).repeatForever(autoreverses: false), value: card.isMatched)
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View {
        VStack {
            HStack {
              
               
            }
            HStack {
              
            }
        }
        .padding()
        .foregroundColor(.green)
    }
}
