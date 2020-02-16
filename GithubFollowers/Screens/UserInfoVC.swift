//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 14/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    lazy var headerView = UIView()
    lazy var itemViewOne = UIView()
    lazy var itemViewTwo = UIView()
    lazy var dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo() {
        GitHubManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: userInfo), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: userInfo), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: userInfo), to: self.itemViewTwo)
                    self.dateLabel.text = "On GitHub since \(userInfo.createdAt.asDisplayFormat)"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func layoutUI() {
        let itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        
        var currentReferenceForTopAnchor = view.safeAreaLayoutGuide.topAnchor
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.topAnchor.constraint(equalTo: currentReferenceForTopAnchor, constant: padding),
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
            currentReferenceForTopAnchor = itemView.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 180),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
