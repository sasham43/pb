//
//  PhoneConnector.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import Foundation
import WatchConnectivity
import SwiftUI

class PhoneConnector:NSObject,ObservableObject {
    
    // public variables
    
    static let shared = PhoneConnector()
    
    public let session = WCSession.default
        
//    @Published var users:[User] = []
        
    private override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
}

// MARK: - WCSessionDelegate methods
extension PhoneConnector:WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("session activation failed with error: \(error.localizedDescription)")
            return
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: String = "") {
        dataReceivedFromPhone(userInfo)
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: String) {
        dataReceivedFromPhone(message)
    }
    
}


// MARK: - send data to phone
extension PhoneConnector {
    
    public func sendDataToPhone(_ info: String) {
//        let dict:[String:Any] = ["data":user.encodeIt()]
        
        //session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage([info : ""], replyHandler: nil)
    }
    
}

// MARK: - receive data
extension PhoneConnector {
    
    public func dataReceivedFromPhone(_ info:String) {
//        let data:Data = info["data"] as! Data
//        let user = User.decodeIt(data)
//        DispatchQueue.main.async {
//            self.users.append(user)
//        }
        print("Received from phone: \(info)")
    }
    
}