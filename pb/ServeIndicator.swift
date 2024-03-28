//
//  ServeIndicator.swift
//  pb
//
//  Created by Sasha Kramer on 3/28/24.
//

import SwiftUI

struct ServeIndicator : View {
    @State var filled : Bool
    
    var body : some View {
        Circle()
            .fill(filled ? .blue : .clear)
            .stroke(.blue, lineWidth: 1)
//                                .border(.white, width: )
            .frame(width: 10, height: 10)
    }
}
