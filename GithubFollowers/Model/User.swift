// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

struct User: Codable {
    let avatarUrl: String
    var bio: String?
    let createdAt: String
    let followers: Int
    let following: Int
    let htmlUrl: String
    var location: String?
    let login: String
    var name: String?
    let publicGists: Int
    let publicRepos: Int
}
