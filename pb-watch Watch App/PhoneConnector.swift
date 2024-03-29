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
    
//    @EnvironmentObject var scoreData : ScoreData
//    var scoreData =  ScoreData()
    let scoreData = ScoreData.shared
    
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
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        dataReceivedFromPhone(userInfo)
    }
    
    // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        dataReceivedFromPhone(message)
    }
    
}


// MARK: - send data to phone
extension PhoneConnector {
    
    public func sendDataToPhone(_ info: [String: Any]) {
//        let dict:[String:Any] = ["data":user.encodeIt()]
        
        //session.transferUserInfo(dict)
        // for testing in simulator we use
        session.sendMessage(info, replyHandler: nil)
    }
    
}

// MARK: - receive data
extension PhoneConnector {
    
    public func dataReceivedFromPhone(_ info:[String : Any]) {
        print("Received from phone: \(info)")
        if let homeScore = info["home"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.homeScore = homeScore
            }
            print("home score received: \(homeScore)")
        } else {
            print("could not unpack value")
        }
        if let awayScore = info["away"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.awayScore = awayScore
            }
            print("away score received: \(awayScore)")
        } else {
            print("could not unpack value")
        }
        if let serve = info["serve"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.serve = serve
            }
            print("serve received: \(serve)")
        }
    }
    
}
