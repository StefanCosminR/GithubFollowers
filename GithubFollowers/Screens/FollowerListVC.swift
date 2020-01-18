// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        GitHubManager.shared.getFollowers(for: username, page: 1) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Oh no, it failed 😱", message: error.rawValue, buttonTitle: "Ok 😅")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
