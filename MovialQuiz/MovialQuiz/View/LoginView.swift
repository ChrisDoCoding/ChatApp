//
//  LoginView.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var contentView = UIView()
    
    let loginButton = UIButton()
    let termsButton = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Content View
        contentView.backgroundColor = .white
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
    
    // MARK: - Helper functions
    
    func addContentSubviews() {
        
        // Login Button
        loginButton.setTitle("Login via LINE", for: .normal)
        loginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 1
        loginButton.clipsToBounds = true
        contentView.addSubview(loginButton)

        
        addContentSubviewConstraints()
    }
    
    func addContentSubviewConstraints() {

        // Login button
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(250)
            make.top.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
