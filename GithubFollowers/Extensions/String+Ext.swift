// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import Foundation

extension String {
    var isValidGithubUsername: Bool {
        let regexPattern = #"^[a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38}$"#
        return range(of: regexPattern, options: .regularExpression) != nil
    }
    
}
