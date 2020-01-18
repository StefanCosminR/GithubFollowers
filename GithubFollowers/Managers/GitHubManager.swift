// Create by Stefan Romanescu on 18/01/2020 
// Using Swift 5.0

import Foundation

struct GitHubManager {
    static let shared = GitHubManager()
    private let baseUrl = "https://api.github.com/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], Error>) -> Void) {
        let endpoint = baseUrl + "users/\(username)/followers?per_page=50&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(Errors.invalidURL(url: endpoint)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(Errors.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(Errors.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(Errors.emptyBody))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(Errors.undecodableData))
            }
        }
        
        task.resume()
    }
    
    enum Errors: Error {
        case invalidURL(url: String)
        case networkError
        case invalidResponse
        case emptyBody
        case undecodableData
    }
}
