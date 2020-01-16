// Create by Stefan Romanescu on 16/01/2020 
// Using Swift 5.0

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        font = UIFont.preferredFont(forTextStyle: .title2)

        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter a username"
    }
    
}
