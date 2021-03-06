//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 15/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: ItemInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureActionButton()
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
    
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
