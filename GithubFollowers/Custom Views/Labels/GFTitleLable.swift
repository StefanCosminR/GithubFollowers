// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

import UIKit

class GFTitleLable: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        lineBreakMode               = .byTruncatingTail
        minimumScaleFactor          = 0.9
        textColor                   = .label // dark in light mode and white in dark mode
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
