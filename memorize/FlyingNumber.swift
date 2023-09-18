//
//  FlyingNumber.swift
//  memorize
//
//  Created by Htain Lin Shwe on 12/09/2023.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number,format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle( number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5, x:1, y:1)
                .offset(x:0 , y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
        FlyingNumber(number: 1)
    }
}
