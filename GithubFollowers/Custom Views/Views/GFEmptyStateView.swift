// Create by Stefan Romanescu on 19/01/2020 
// Using Swift 5.0

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLable = GFTitleLable(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLable.text = message
    }
    
    private func configure() {
        addSubview(messageLable)
        addSubview(logoImageView)
        configureMessageLable()
        configureLogoImageView()
    }
    
    private func configureMessageLable() {
        messageLable.numberOfLines = 3
        messageLable.textColor = .secondaryLabel
        messageLable.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: this doesn't look the same on every device
        NSLayoutConstraint.activate([
            messageLable.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
    
}
