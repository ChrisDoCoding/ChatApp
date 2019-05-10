//
//  ChatRoomView.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit

class ChatRoomView: UIView {

    var contentView = UIView()
    var inputTextField = UITextField()
    var sendButton = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Content view
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addContentSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addContentSubviews() {
        inputTextField.backgroundColor = .lightGray
        addSubview(inputTextField)
        
        sendButton.setTitle("SEND", for: .normal)
        sendButton.backgroundColor = .green
        addSubview(sendButton)
        
        addContentSubviewConstraints()
    }
    
    func addContentSubviewConstraints() {
        
        inputTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(snp.centerY)
            make.leading.equalTo(snp.leading)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.top.equalTo(snp.centerY)
            make.leading.equalTo(inputTextField.snp.trailing)
            make.trailing.equalTo(snp.trailing)
        }
    }
    
}
