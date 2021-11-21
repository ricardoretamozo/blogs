//
//  SigninViewController.swift
//  blogs
//
//  Created by ricardo on 11/20/21.
//  Copyright © 2021 ricardo. All rights reserved.
//

import UIKit

class SignInViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                let navVC = UINavigationController(rootViewController: vc)
                self.present (navVC, animated: true, completion: nil)
            }
        }
    }
    
}
