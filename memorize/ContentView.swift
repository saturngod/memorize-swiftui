//
//  ContentView.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🐵","🐶","🐷","🌝","🔥","⛈️","🐚","🐼", "🐙" , "🐢","🦀"]
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardCounterAdjuster
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
        .disabled(cardCount + offset > emojis.count || cardCount + offset < 1)
        
    }
        
    
    var cardAdder: some View {
       cardCounterAdjuster(by: +1, symbols: "folder.fill.badge.plus")
    }
    
    var cardRemover: some View {
        cardCounterAdjuster(by: -1, symbols: "folder.fill.badge.minus")
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))])
        {
            ForEach(0..<cardCount,id:\.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
