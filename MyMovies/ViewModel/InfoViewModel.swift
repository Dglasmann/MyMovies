//
//  InfoViewModel.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import Foundation
import Combine

@MainActor
final class InfoViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            posts = try await NetworkManager.shared.fetchPosts()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
