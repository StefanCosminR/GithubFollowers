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
    
    func downloadImage(from urlString: String) {
        // set placeholder otherwise the old avatar will persist until new one is fetched
        image = placeholderImage
        GitHubManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self, let image = image else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }

}
