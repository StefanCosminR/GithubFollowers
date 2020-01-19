// Create by Stefan Romanescu on 19/01/2020 
// Using Swift 5.0

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // TODO: Is this really supposed to go here?
    func downloadImage(from urlString: String) {
        
        // check cache
        let cacheKey = urlString as NSString
        if let image = GitHubManager.shared.cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        // not found in cache, doing network request
        guard let url = URL(string: urlString) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            GitHubManager.shared.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }

}
