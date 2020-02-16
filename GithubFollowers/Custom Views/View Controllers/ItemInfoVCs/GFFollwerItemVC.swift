//
//  GFFollwerItemVC.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 15/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFFollowerItemVC: UIViewController {
    
    var mainView: GFItemInfoVC
    private var user: User
    
    init(user: User) {
        mainView = GFItemInfoVC(user: user)
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
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
