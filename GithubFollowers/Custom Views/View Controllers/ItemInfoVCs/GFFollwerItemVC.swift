//
//  GFFollwerItemVC.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 15/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFFollowerItemVC: UIViewController {
    
    private var mainView: GFItemInfoVC
    private var user: User
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        mainView = GFItemInfoVC(user: user)
        self.user = user
        super.init(nibName: nil, bundle: nil)
        mainView.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    @objc func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    func configureItems() {
        addChild(mainView)
        view.addSubview(mainView.view)
        mainView.willMove(toParent: self)
                
        mainView.itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        mainView.itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        mainView.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
