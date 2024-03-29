//
//  WatchConnector.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import Foundation
import WatchConnectivity

class WatchConnector: NSObject, ObservableObject {
    // public variables
    let scoreData = ScoreData.shared
    
    static let shared = WatchConnector()
    
    public var session = WCSession.default
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
}

extension WatchConnector: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        session.activate()
    }
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            if let error = error {
                print("session activation failed with error: \(error.localizedDescription)")
                return
            }
        }
        
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
            dataReceivedFromWatch(userInfo)
        }
        
        // MARK: use this for testing in simulator
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            dataReceivedFromWatch(message)
        }
}


extension WatchConnector {
    public func sendDataToWatch(_ data: [String : Any]){
        session.sendMessage(data, replyHandler: nil)
//        session.sendMessage(data, replyHandler: nil)
    }
}

extension WatchConnector {
    public func dataReceivedFromWatch(_ info: [String : Any]){
        print("Watch data: \(info)")
        
        if let homeScore = info["home"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.homeScore = homeScore
            }
            print("home score received: \(homeScore)")
        }
        if let awayScore = info["away"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.awayScore = awayScore
            }
            print("away score received: \(awayScore)")
        }
        if let serve = info["serve"] as? Int {
            DispatchQueue.main.async {
                self.scoreData.serve = serve
            }
            print("serve received: \(serve)")
        }
    }
}
