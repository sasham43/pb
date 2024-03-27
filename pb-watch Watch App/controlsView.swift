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
                    Text("Home")
                    Button("+") {
                        print("+")
                        PhoneConnector.shared.sendDataToPhone("+")
                        
                    }
                    Button("-") {
                        print("-")
                    }
                }
                VStack {
                    Text("Away")
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
