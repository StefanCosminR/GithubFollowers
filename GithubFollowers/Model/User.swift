// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

struct User: Codable {
    let avaratUrl: String
    let bio: String?
    let createdAt: String
    let followers: Int
    let following: Int
    let htmlUrl: String
    let location: String?
    let login: String
    let name: String?
    let publicGists: Int
    let publicRepos: Int
}
