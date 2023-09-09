//
//  AspectVGrid.swift
//  memorize
//
//  Created by Htain Lin Shwe on 09/09/2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat = 1
    @ViewBuilder var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)], spacing: 0)
            {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
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
   
}
