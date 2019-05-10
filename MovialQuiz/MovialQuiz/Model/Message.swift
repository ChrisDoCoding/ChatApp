//
//  Message.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import Foundation
import Firebase

class Message {
    
    let ref: DatabaseReference?
    var fromUser: String
    var message: String
    
    init() {
        self.ref = nil
        self.fromUser = ""
        self.message = ""
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let fromUser = value["fromUser"] as? String,
            let message = value["message"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.fromUser = fromUser
        self.message = message
    }
    
    func toAnyObject() -> Any {
        return [
            "fromUser": fromUser,
            "message": message
        ]
    }
}
