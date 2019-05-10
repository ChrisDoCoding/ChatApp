//
//  ChatRoom.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import Foundation
import Firebase

struct ChatRoom {
    
    let ref: DatabaseReference?
    var roomName: String
    var users: [String]
    var messages: [Message]
    
    init(roomName: String) {
        self.ref = nil
        self.roomName = roomName
        self.users = []
        self.messages = []
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let roomName = value["roomName"] as? String,
            let users = value["users"] as? [String],
            let messages = value["messages"] as? [Message] else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.roomName = roomName
        self.users = users
        self.messages = messages
    }
    
    func toAnyObject() -> Any {
        return [
            "roomName": roomName,
            "users": users,
            "messages": messages
        ]
    }
}


// Data struct of ChatRooms
//{
//    "chatRooms" : {
//        "F5E9206B-E9C9-4033-8F2C-F847E81AE41F" : {
//            "messages" : [ {
//                  "fromUser" : "7dN0HCkWkbPw1LfzObDHNta3mFr2",
//                  "message" : "Message 1"
//                  }, {
//                  "fromUser" : "7dN0HCkWkbPw1LfzObDHNta3mFr2",
//                  "message" : "Message 2"
//            } ],
//            "roomName" : "Test I",
//            "users" : [ "7dN0HCkWkbPw1LfzObDHNta3mFr2" ]
//        }
//    }
//}

