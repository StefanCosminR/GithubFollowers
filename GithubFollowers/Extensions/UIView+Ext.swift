//
//  UIView+Ext.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 02/03/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
