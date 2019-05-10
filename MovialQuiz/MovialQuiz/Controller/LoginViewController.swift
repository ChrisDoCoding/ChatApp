//
//  LoginViewController.swift
//  MovialQuiz
//
//  Created by Chris Chen on 2019/5/9.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let loginButton = UIButton()
        loginButton.setTitle("Login via Facebook", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(45)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }        
    }
    
    @objc func goLogin() {
        DataManager.login(failure: { (error) in
            print(error)
        }) { (result) in
            self.dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
