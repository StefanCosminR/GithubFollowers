// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.3) { containerView.alpha = 0.8 }
        
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activitiIndicator)
        
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activitiIndicator.startAnimating()
    }
    
    func dismissLoadingViewFromMainThread() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
