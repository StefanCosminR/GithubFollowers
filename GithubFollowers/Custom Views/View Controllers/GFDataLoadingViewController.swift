//
//  GFDataLoadingViewController.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 29/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFDataLoadingViewController: UIViewController {
    
    private var containerView: UIView?

    func showLoadingView() {
        guard containerView == nil else { return }
        
        containerView = UIView(frame: view.bounds)
        guard let existingContainerView = containerView else { return }
        
        view.addSubview(existingContainerView)
        existingContainerView.backgroundColor = .systemBackground
        existingContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.3) { existingContainerView.alpha = 0.8 }
        
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        existingContainerView.addSubview(activitiIndicator)
        
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activitiIndicator.startAnimating()
    }
    
    func dismissLoadingViewFromMainThread() {
        DispatchQueue.main.async {
            self.containerView?.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
