//
//  ViewController.swift
//  blogs
//
//  Created by ricardo on 11/20/21.
//  Copyright © 2021 ricardo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                self.present (vc, animated: true, completion: nil)
            }
        }
    }
}
 
