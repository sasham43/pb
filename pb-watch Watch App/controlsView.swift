//
//  controlsView.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

struct controlsView: View {
    
//    func sendMessage(
    
    @State private var isShowingAlert : Bool = false
    
    
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
                        print("watch +")
                        PhoneConnector.shared.sendDataToPhone(["watch home" : "+"])
                    }
                    .font(.system(size: 32))
                    Button("-") {
                        print("-")
                    }
                    .font(.system(size: 32))
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
                    .font(.system(size: 32))
                    Button("-") {
                        print("-")
                    }
                    .font(.system(size: 32))
                }
            }
            
            
            VStack {
                HStack {
                    Button("Reset") {
                        print("Reset?")
                        isShowingAlert = true
                    }
                    .alert("Are you sure you want to reset the game?", isPresented: $isShowingAlert){
                        Button("Yes"){
                            print("Reset!!")
                        }
                        Button("No", role: .cancel){}
                    }
                    Button("Serve") {
                        print("next serve")
                    }
                }
            }
        }
        .onAppear {
            print("A wild watch appeared!")
            PhoneConnector.shared.sendDataToPhone(["Handshake" : ""])
        }
    }
        
}

#Preview {
    controlsView()
}
