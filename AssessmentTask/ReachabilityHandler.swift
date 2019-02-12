//
//  ReachabilityHandler.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import Reachability

class ReachabilityHandler: NSObject {
    static let shared = ReachabilityHandler()
    private let reachability = Reachability()
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            return
        case .none:
            Alert.showApiErrorAlert(message: NO_NETWORK_ERRORMESSAGE)
        }
    }
    
    func checkReachability()->Bool{
        
        switch self.reachability!.connection {
        case .wifi, .cellular:
            return true
        case .none:
            return false
        }
    }
}
