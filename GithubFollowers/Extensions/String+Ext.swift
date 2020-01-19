// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import Foundation

fileprivate let githubUsernameRegex = try! NSRegularExpression(pattern: #"^[a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38}$"#)

extension String {
    var isValidGithubUsername: Bool {
        let range = NSRange(location: 0, length: utf16.count)
        return githubUsernameRegex.firstMatch(in: self, options: [], range: range) != nil
    }
    
}
