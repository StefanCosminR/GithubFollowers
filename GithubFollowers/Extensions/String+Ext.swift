// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import Foundation

fileprivate let githubUsernameRegex = try! NSRegularExpression(pattern: #"^[a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38}$"#)

extension String {
    var isValidGithubUsername: Bool {
        let range = NSRange(location: 0, length: utf16.count)
        return githubUsernameRegex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    var asDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
    
        return dateFormatter.date(from: self)
    }
    
    var asDisplayFormat: String {
        guard let date = self.asDate else { return "N/A" }
        return date.asMonthYearFormat
    }
}
