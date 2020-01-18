// Create by Stefan Romanescu on 17/01/2020 
// Using Swift 5.0

import Foundation

extension String {
    var isValidGithubUsername: Bool {
        let phoneNumberFormat = #"/^[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}$/i"#
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberFormat)
        return numberPredicate.evaluate(with: self)
    }
    
}
