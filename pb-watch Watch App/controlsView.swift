//
//  controlsView.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

struct controlsView: View {
    
//    func sendMessage(
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Circle()
                            .fill(.blue)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                    }
                    Text("Home: 0")
                    Button("+") {
                        print("+")
                        PhoneConnector.shared.sendDataToPhone("+")
                        
                    }
                    Button("-") {
                        print("-")
                    }
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                    }
                    Text("Away: 0")
                    Button("+") {
                        print("+")
                    }
                    Button("-") {
                        print("-")
                    }
                }
            }
            
            
            VStack {
                HStack {
                    Button("Reset") {
                        print("REset")
                    }
                    Button("Serve") {
                        print("next serve")
                    }
                }
            }
        }
       
    }
}

#Preview {
    controlsView()
}
