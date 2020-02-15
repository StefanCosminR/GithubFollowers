//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 14/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        lineBreakMode               = .byTruncatingTail
        minimumScaleFactor          = 0.9
        textColor                   = .secondaryLabel
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
