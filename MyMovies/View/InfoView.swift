//
//  InfoView.swift
//  MyMovies
//
//  Created by Sasha Soldatov on 22.08.2026.
//

import SwiftUI

struct InfoView: View {
    @ObservedObject var viewModel: InfoViewModel
    @ObservedObject var quizStore: QuizStore
    
    var titleOn: Bool
    var rowHeight: Double
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.orange)
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                        Button("Повторить") {
                            Task { await viewModel.loadPosts() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    
                    List {
                        if !quizStore.learnedPosts.isEmpty {
                            Section("Изучено в викторине") {
                                ForEach(quizStore.learnedPosts) { post in
                                    NavigationLink(destination: InfoDetails(post: post)) {
                                        InfoRow(post: post, rowHeight: rowHeight)
                                    }
                                }
                            }
                        }
                        Section(quizStore.learnedPosts.isEmpty ? "" : "Все фильмы") {
                            ForEach(viewModel.posts) { post in
                                NavigationLink(destination: InfoDetails(post: post)) {
                                    InfoRow(post: post, rowHeight: rowHeight)
                                }
                            }
                        }
                        
                    }
                    .animation(.easeInOut, value: quizStore.learnedPosts.count)
                }
            }
            .navigationTitle(titleOn ? "Фильмы и сериалы": "")
            .navigationBarTitleDisplayMode(titleOn ? .automatic : .inline)
        }
        .task {
            if viewModel.posts.isEmpty {
                await viewModel.loadPosts()
            }
        }
    }
}
