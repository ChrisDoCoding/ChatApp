//
//  ChatRoomViewController.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ChatRoomViewController: UIViewController {
    
    var chatRoomView = ChatRoomView()
    var tableView = UITableView()
    var inputTextField = UITextField()
    var roomID: String?
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatRoomView = ChatRoomView(frame: self.view.bounds)
        chatRoomView.translatesAutoresizingMaskIntoConstraints = false
        chatRoomView.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        if let roomID = roomID {
            DataManager.loadMessages(forRoomID: roomID) { [weak self] (results) in
                self?.messages = results
                self?.tableView.reloadData()
            }
        } else {
            roomID = UUID().uuidString
            
            guard let currentUser = Auth.auth().currentUser else {
                return
            }

            var chatRoom = ChatRoom.init(roomName: "TestII")
            chatRoom.users.append(currentUser.uid)
            
            var ref = Database.database().reference(withPath: "chatRooms/" + roomID!)
            ref.setValue(chatRoom.toAnyObject())
            ref = Database.database().reference(withPath: "chatRooms/" + roomID! + "/messages")
//            ref.observe(.value, with: { snapshot in
//                print(snapshot.value as Any)
//                self.messages.removeAll()
//                for child in snapshot.children {
//                    if let snapshot = child as? DataSnapshot,
//                        let message = MessageInfo(snapshot: snapshot) {
//                        self.messages.append(message)
//                        self.tableView.reloadData()
//                    }
//                }
//            })

        }
        
        view.addSubview(chatRoomView)
        self.chatRoomView = chatRoomView
        
        chatRoomView.snp.makeConstraints({ (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leadingMargin)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailingMargin)
            } else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        })
        
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    

    @objc func sendButtonTapped(_ sender: UIButton) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        guard let roomID = roomID else {
            return
        }
        
        let ref = Database.database().reference(withPath: "chatRooms/" + roomID + "/messages")///" + String(messages.count))
        let message = Message()
        message.fromUser = currentUser.uid
        message.message = chatRoomView.inputTextField.text ?? ""
        
        ref.setValue(message.toAnyObject())
        messages.append(message)
        
        chatRoomView.inputTextField.text = ""
    }
}


extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "messageCell")
        
        cell.textLabel?.text = messages[indexPath.row].message
        
        return cell
    }
    
    
}
