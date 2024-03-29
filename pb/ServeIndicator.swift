//
//  ServeIndicator.swift
//  pb
//
//  Created by Sasha Kramer on 3/28/24.
//

import SwiftUI

struct ServeIndicator : View {
    @State var filled : Bool
    
    
    let yellowColor = Color(red: 255 / 255, green: 191 / 255, blue: 70 / 255)
    
    var body : some View {
        Circle()
            .fill(filled ? yellowColor : .clear)
            .stroke(yellowColor, lineWidth: 1)
//                                .border(.white, width: )
            .frame(width: 10, height: 10)
    }
}
