//
//  ProfileViewController.swift
//  blogs
//
//  Created by ricardo on 11/20/21.
//  Copyright © 2021 ricardo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
           title: "Sign Out",
            style: .done,
           target: self,
           action: #selector(didTapSignOut)
        )
    }
    
    @objc private func didTapSignOut() {
        
    }
}
