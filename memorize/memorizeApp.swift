//
//  memorizeApp.swift
//  memorize
//
//  Created by Htain Lin Shwe on 22/08/2023.
//

import SwiftUI

@main
struct memorizeApp: App {
    
    @StateObject var game = EmojMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
    
}
