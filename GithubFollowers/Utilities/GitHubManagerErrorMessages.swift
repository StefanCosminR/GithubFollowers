// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

enum GitHubManagerErrorMessages: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidRequest = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
