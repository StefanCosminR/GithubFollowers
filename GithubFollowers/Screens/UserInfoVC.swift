//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 14/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    lazy var headerView = UIView()
    lazy var itemViewOne = UIView()
    lazy var itemViewTwo = UIView()
    lazy var dateLabel = GFBodyLabel(textAlignment: .center)
    weak var delegate: FollowerListViewControllerDelegate!
    
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
            case .success(let user):
                DispatchQueue.main.async { self.configureUIelements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIelements(with user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "On GitHub since \(user.createdAt.asMonthYearFormat)"
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "THe url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers > 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers 😢", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
