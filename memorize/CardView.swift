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
       
        Pie(endAngle: .degrees(200))

            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size:Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scalFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1,contentMode: .fit)
            )
            .padding(Constants.Pie.inset)
            .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(id: "test", isFaceUp: true, content: "This is long content for showing the card and fit it"))
                CardView(Card(id: "test", content: "This is long content for showing the card and fit it"))
            }
            HStack {
                CardView(Card(id: "test", isFaceUp: true, content: "This is long content for showing the card and fit it"))
                CardView(Card(id: "test", content: "This is long content for showing the card and fit it"))
            }
        }
        .padding()
        .foregroundColor(.green)
    }
}
