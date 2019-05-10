//
//  DataManager.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit


class DataManager {
    
    static func login(failure onFailure: ((NSError) -> ())? = nil,
                      success onSuccess: @escaping ((User) -> ())) {
        
        let permissions = ["public_profile"]
        let loginManager = LoginManager()
        loginManager.logIn(permissions: permissions, from: nil) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (result, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                }
                
                if let user = Auth.auth().currentUser {
                    onSuccess(user)
                }
            })
            //            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            //                if let error = error {
            //                    print("Login error: \(error.localizedDescription)")
            //                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
            //                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //                    alertController.addAction(okayAction)
            //                }
            //
            //                if let user = Auth.auth().currentUser {
            //                    onSuccess(user)
            //                }
            //            }
        }
    }
    
    static func loadChatRooms(failure onFailure: @escaping ((Error) -> ()),
                              success onSuccess: @escaping (([ChatRoom]) -> ())) {
        let ref = Database.database().reference(withPath: "chatRooms")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var chatRooms: [ChatRoom] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let chatRoom = ChatRoom(snapshot: snapshot) {
                    chatRooms.append(chatRoom)
                }
            }
            onSuccess(chatRooms)
        }) { (error) in
            onFailure(error)
        }
    }
    
    static func loadMessages(forRoomID id: String,
                             success onSuccess: @escaping (([Message]) -> ())) {
        let ref = Database.database().reference(withPath: "chatRooms/" + id + "/messages")
        ref.observe(.value) { (snapshot) in
            var messages: [Message] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let message = Message(snapshot: snapshot) {
                    messages.append(message)
                }
            }
            onSuccess(messages)
        }
    }
}

