//
//  Cardify.swift
//  memorize
//
//  Created by Htain Lin Shwe on 10/09/2023.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
    }
    
    
    
    
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
