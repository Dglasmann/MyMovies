//
//  QuizStore.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 29.08.2026.
//

import Foundation
import Combine

@MainActor
final class QuizStore: ObservableObject {
    @Published private(set) var learnedPosts: [Post] = []
    
    private let storageKey = "learnedPosts"
    
    init() {
        
    }
    
    func markLearned(_ post: Post) {
        guard !learnedPosts.contains(where: { $0.id == post.id }) else { return }
        learnedPosts.insert(post, at: 0)
        save()
    }
    
    func isLearned(_ post: Post) -> Bool {
        learnedPosts.contains(where: { $0.id == post.id })
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(learnedPosts) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let posts = try? JSONDecoder().decode([Post].self, from: data) else { return }
        learnedPosts = posts
     }
}
