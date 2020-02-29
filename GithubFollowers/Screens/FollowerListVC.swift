// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import UIKit

protocol FollowerListViewControllerDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingViewController {
    
    enum Section {
        case main
    }
    
    var username: String
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        self.title = username
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false // remove dimming of collection view when searching
        navigationItem.searchController = searchController
        
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        GitHubManager.shared.getFollowers(for: username, page: page) {[weak self] result in
            guard let self = self else { return }
            self.dismissLoadingViewFromMainThread()
            
            switch result {
            case .success(let followers):
                if followers.count < 50 {
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😃."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                
                DispatchQueue.main.async {
                    if let searchController = self.navigationItem.searchController, searchController.searchBar.text != "" {
                        self.updateSearchResults(for: searchController)
                    } else {
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.updateData(on: self.followers)
                        }
                    }
                }
                
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Oh no, it failed 😱", message: error.rawValue, buttonTitle: "Ok 😅")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView)
        { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        }
    }
    
    @objc func favoriteButtonTapped() {
        showLoadingView()
        
        GitHubManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingViewFromMainThread()
            
            switch result {
            case .success(let user):
                let favorite = Follower(avatarUrl: user.avatarUrl, login: user.login)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }

                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success", message: "You have succesfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wront", message: error.rawValue, buttonTitle: "Ok 😢")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wront", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreFollowers else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
        
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        isSearching = true
        
        if filter.isEmpty {
            filteredFollowers.removeAll()
            isSearching = false
            updateData(on: followers)
        } else {
            filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
            updateData(on: filteredFollowers)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFollowers.removeAll()
        isSearching = false
        updateData(on: followers)
    }
    
}

extension FollowerListVC: FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
