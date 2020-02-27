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
        
        layer.cornerRadius          = 10
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        
        
        backgroundColor             = UIColor(named: "UITextFieldColor")!
        autocorrectionType          = .no
        returnKeyType               = .go
        clearButtonMode             = .whileEditing
        
        placeholder                 = "Enter a username"
    }
    
}
