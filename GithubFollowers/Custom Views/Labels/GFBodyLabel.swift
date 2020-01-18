// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        font                        = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode               = .byWordWrapping
        minimumScaleFactor          = 0.75
        textColor                   = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
