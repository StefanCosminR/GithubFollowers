//
//  Date+Extensions.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 16/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import Foundation

extension Date {
    var asMonthYearFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
