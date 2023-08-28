//
//  CardView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack {
            Group {
                base.fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
           
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        
    }
}
