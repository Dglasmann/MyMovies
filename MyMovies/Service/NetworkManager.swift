//
//  NetworkManager.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case requestFailed
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Некорректный адрес"
        case .requestFailed:
            return "Не удалось загрузить данные"
        case .decodingFailed:
            return "Не удалось распарсить данные"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let cacheKey = "cached_posts"
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "https://api.tvmaze.com/shows") else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let shows = try JSONDecoder().decode([Show].self, from: data)
            
            let posts = shows.prefix(20).map { show -> Post in
                let cleanSummary = (show.summary ?? "Описание отсутствует")
                    .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
                return Post(
                    id: show.id,
                    title: show.name,
                    description: cleanSummary,
                    imageURL: show.image?.original ?? ""
                )
                
            }
            
            saveToCache(posts)
            return posts
        } catch {
            if let cached = loadFromCache() {
                return cached
            }
            throw NetworkError.requestFailed
        }
    }
    
    private func saveToCache(_ posts: [Post]) {
        if let data = try? JSONEncoder().encode(posts) {
            UserDefaults.standard.set(data, forKey: cacheKey)
        }
    }
    
    private func loadFromCache() -> [Post]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey),
              let posts = try? JSONDecoder().decode([Post].self, from: data) else { return nil }
        return posts
    }
    
}
